extends Node2D

func _ready():
	MessageBus.deleteTunnel.connect(finish)

func finish():
	queue_free()
