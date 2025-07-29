extends Node2D

func _ready() -> void:
	MessageBus.deleteTunnel.connect(delete)

func delete():
	queue_free()
