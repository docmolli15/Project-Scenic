extends Node2D

@onready var timer = %Timer
@onready var viewport_size: Vector2 = get_viewport().size

@export var stop_time: float = 16.0
@export var station_y_offset: float = -20.0  # vertical offset from bottom of screen

var stop_point: Vector2
var delete_point: Vector2

# same signal being used on multiple operations, ie station or tunnel

func _ready():
	MessageBus.departed_station.connect(depart)
	viewport_size = get_viewport().size
	var y_pos = viewport_size.y + station_y_offset
	stop_point = Vector2(viewport_size.x / 2, y_pos) 
	delete_point = Vector2(-200, y_pos)              
	arrive()

func arrive():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", stop_point, stop_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

func depart():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", delete_point, stop_time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	timer.start()

func delete() -> void:
	queue_free()
