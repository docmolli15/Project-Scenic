extends Node2D

@onready var timer = %Timer
@onready var stop_point: Vector2 = Vector2(960, 1060)
@onready var delete_point: Vector2 = Vector2(-120, 1060)

@export var stop_time: float = 16.0

# same signal being used on multiple operations, ie station or tunnel

func _ready():
	MessageBus.departed_station.connect(depart)
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
