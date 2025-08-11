extends Node2D

@onready var delete_point: Vector2 = Vector2(-1500, 1017)
@onready var duration: float = 32.0
@onready var DeleteTimer = %Timer

func _ready():
	transition()

func transition():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", delete_point, duration)
	DeleteTimer.start()

func delete() -> void:
	queue_free()
