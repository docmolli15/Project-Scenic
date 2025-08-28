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
	["A", "D"]: 1600, ["D", "A"]: 1600,
	["B", "D"]: 1200, ["D", "B"]: 1200,
	["C", "D"]: 800, ["D", "C"]: 800,
	["E", "D"]: 500, ["D", "E"]: 500,
	["F", "D"]: 500, ["D", "F"]: 500
}

const TUNNEL_TRIGGERS = {
	["A", "D"]: {"at": [0.5, 0.9], "frame": [2, 1]}, ["D", "A"]: {"at": [0.1, 0.5], "frame": [2, 3]},
	["B", "D"]: {"at": [0.5], "frame": [1]}, ["D", "B"]: {"at": [0.5], "frame": [3]},
	["C", "D"]: {"at": [0.55, 0.9], "frame": [0, 1]}, ["D", "C"]: {"at": [0.1, 0.45], "frame": [0, 2]},
	["E", "D"]: [], ["D", "E"]: [],
	["F", "D"]: {"at": [0.1], "frame": [1]}, ["D", "F"]: {"at": [0.15], "frame": [0]}
}

@onready var buttons = [%"A", %"B", %"C", %"D", %"E", %"F"]
var you_are_here: TextureButton = null

func _ready() -> void:
	# Connect all buttons' pressed signals
	for button in buttons:
		button.pressed.connect(_on_button_pressed.bind(button))
	
	# Wait a frame before initializing (in case Global hasn't updated yet)
	await get_tree().process_frame
	update_buttons()

func _on_button_pressed(button: TextureButton):
	if button.disabled:
		return
	
	you_are_here = button
	# Update visuals to reflect selection
	for b in buttons:
		if b == you_are_here:
			b.texture_normal = preload("res://art/UI/station UI/city_toggled.png")
		elif not b.disabled:
			b.texture_normal = preload("res://art/UI/station UI/city.png")

func update_buttons():
	var current_station = Global.route_info.get("Station", "")
	if current_station == "":
		return
	
	var valid_destinations = CONNECTIONS.get(current_station, [])

	for button in buttons:
		if button.name in valid_destinations:
			button.disabled = false
			button.texture_normal = preload("res://art/UI/station UI/city.png")
		else:
			button.disabled = true
			button.texture_normal = preload("res://art/UI/station UI/city_inactive.png")
	
	# Clear selected if it's no longer valid
	if you_are_here and (you_are_here.name not in valid_destinations):
		you_are_here = null
