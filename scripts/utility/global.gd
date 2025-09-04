extends Node

var current_save := 1
var current_speed: float
var parralax_frame: int
var funds: int
var trip_progress: float
var current_station = "in_transit"
var route_info = {
	"Station": "D",
	"Duration": 0, 
	"Tunnel Triggers": [], 
	"Frames": []
}


func _ready():
	pass

func get_active_player_data() -> Node:
	match current_save:
		1:
			return player_data_1
		2:
			return player_data_2
		3:
			return player_data_3
		_:
			return player_data_1
