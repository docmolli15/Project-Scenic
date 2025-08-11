extends Node
# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum {FIRST, SECOND}'
@export var scroll_multiplier: float = 30.0 
@export var farground_autoscroll: float = -1
@export var background_autoscroll: float = -2
@export var midground_autoscroll: float = -7
@export var tracks_autoscroll: float = -12
@export var foreground_autoscroll: float = -15
@export var spawn_location: Vector2 = Vector2( 2000,1060) 

@onready var farground = %Farground
@onready var background = %Background
@onready var midground = %Midground
@onready var tracks = %Tracks
@onready var foreground = %Foreground
@onready var point_of_interest = %PointOfInterest

var autoscroll_map = {
	"Farground": farground_autoscroll,
	"Background": background_autoscroll,
	"Midground": midground_autoscroll,
	"Tracks": tracks_autoscroll,
	"Foreground": foreground_autoscroll
	}

const STATION = preload("res://scenes/environment/station.tscn")
const TUNNEL = preload("res://scenes/environment/tunnel.tscn")

func _ready() -> void:
	MessageBus.arrived_at_station.connect(spawn_station)
	MessageBus.tunnelled_through.connect(spawn_tunnel)

func _process(_delta) -> void:
	scroll_multiplier = Global.current_speed
	_scroll()

func _scroll():
	for layer in get_children():
		if layer is Parallax2D and autoscroll_map.has(layer.name):
			layer.autoscroll.x = autoscroll_map[layer.name] * Global.current_speed

func spawn_station():
	var station_scene = STATION.instantiate()
	point_of_interest.add_child(station_scene)
	station_scene.position = Vector2(2000, 1060)

func spawn_tunnel():
	var tunnel_scene = TUNNEL.instantiate()
	point_of_interest.add_child(tunnel_scene)
	tunnel_scene.position = Vector2(3300, 1017)
