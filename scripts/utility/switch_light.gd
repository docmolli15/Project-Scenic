extends Area2D

@onready var light = %PointLight2D

func _turn_off(_body):
	light.enabled = false

func _turn_on(_body):
	light.enabled = true
