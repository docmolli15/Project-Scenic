extends Node2D

@onready var delete_point: Vector2 = Vector2(-1500, 1017)
@onready var duration: float = 32.0
@onready var DeleteTimer = %Timer

@export var parallax_frame = 0

func _ready():
	transition()

func transition():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", delete_point, duration)
	DeleteTimer.start()

func delete() -> void:
	MessageBus.back_to_cruise.emit()
	print("tunnel message fired")
	queue_free()
