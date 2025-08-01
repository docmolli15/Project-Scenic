extends Node2D

#INCOMING SIGNAL CAUSES TUNNEL TO DELETE ITSELF
func _ready():
	MessageBus.deleteTunnel.connect(finish)

func finish():
	queue_free()
