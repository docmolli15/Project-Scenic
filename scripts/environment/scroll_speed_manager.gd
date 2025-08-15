extends Node2D

@export var scroll_multiplier: float = 30.0 

@export var farground_autoscroll: float = -1
@export var background_autoscroll: float = -2
@export var midground_autoscroll: float = -7
@export var tracks_autoscroll: float = -12
@export var foreground_autoscroll: float = -15

var autoscroll_map = {
	"Farground": farground_autoscroll,
	"Background": background_autoscroll,
	"Midground": midground_autoscroll,
	"Tracks": tracks_autoscroll,
	"Foreground": foreground_autoscroll
	}

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	scroll_multiplier = Global.current_speed
	_scroll()

func _scroll():
	for layer in get_children():
		if layer is Parallax2D and autoscroll_map.has(layer.name):
			layer.autoscroll.x = autoscroll_map[layer.name] * Global.current_speed
