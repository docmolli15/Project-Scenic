extends Node2D

@onready var timer = %Timer

func _ready():
	MessageBus.stationDelete.connect(delete)

func delete():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", Vector2(-80, 1060), 18.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()
