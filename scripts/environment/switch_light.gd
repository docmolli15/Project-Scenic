extends Area2D

@onready var light = %PointLight2D

func _ready() -> void:
	light.enabled = true

func _turn_off(area):
	if area.name == "DarkZone":
		light.enabled = false

func _turn_on(area):
	if area.name == "DarkZone":
		light.enabled = true
