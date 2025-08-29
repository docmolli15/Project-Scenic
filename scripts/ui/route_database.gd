extends Node

const CONNECTIONS = {
	"A": ["D"],
	"B": ["D"],
	"C": ["D"],
	"D": ["A","B","C","E","F"],
	"E": ["D"],
	"F": ["D"],
}

const TRIP_DURATIONS = {
	"A-D": 1600, "D-A": 1600,
	"B-D": 1200, "D-B": 1200,
	"C-D": 800,  "D-C": 800,
	"E-D": 500,  "D-E": 500,
	"F-D": 500,  "D-F": 500,
}

const TUNNEL_TRIGGERS = {
	"A-D": {"at": [0.5, 0.9], "frame": [2, 1]}, "D-A": {"at": [0.1, 0.5], "frame": [2, 3]},
	"B-D": {"at": [0.5], "frame": [1]}, "D-B": {"at": [0.5], "frame": [3]},
	"C-D": {"at": [0.55, 0.9], "frame": [0, 1]}, "D-C": {"at": [0.1, 0.45], "frame": [0, 2]},
	"E-D": [], "D-E": [],
	"F-D": {"at": [0.1], "frame": [1]}, "D-F": {"at": [0.15], "frame": [0]},
}

@onready var buttons = [%"A", %"B", %"C", %"D", %"E", %"F"]
var destination_chosen: bool = false
var you_are_here: TextureButton = null


func _ready() -> void:
	for node in get_tree().get_nodes_in_group("Cities"):
		if node is TextureButton:
			node.pressed.connect(select_destination.bind(node))

	MessageBus.update_map_choices.connect(update_locations)

func select_destination(button: TextureButton):
	destination_chosen = true
	Global.route_info['Station'] = button.name
	var city_pair = "%s-%s" % [Global.current_station, button.name]
	print("Looking for city pair:", city_pair)
	print("Has duration?", TRIP_DURATIONS.has(city_pair))
	print("Has tunnel triggers?", TUNNEL_TRIGGERS.has(city_pair))
	if TRIP_DURATIONS.has(city_pair):
			Global.route_info['Duration'] = TRIP_DURATIONS[city_pair]
	if TUNNEL_TRIGGERS.has(city_pair):
		var trigger_info = TUNNEL_TRIGGERS[city_pair]
		if typeof(trigger_info) == TYPE_DICTIONARY:
			Global.route_info['Tunnel Triggers'] = trigger_info.get("at", [])
			Global.route_info['Frames'] = trigger_info.get("frame", [])
		else:
			Global.route_info['Tunnel Triggers'] = []
			Global.route_info['Frames'] = []
	print(Global.route_info)

func update_locations():
	destination_chosen = false
	var valid_connections = CONNECTIONS.get(Global.current_station, [])
	for node in get_tree().get_nodes_in_group("Cities"):
		if node.name in valid_connections:
			node.visible = true
		else:
			node.visible = false
	
