extends Node2D

func _ready():
	pass

func _on_shovel_coal_pressed():
	MessageBus.shovelCoal.emit()
