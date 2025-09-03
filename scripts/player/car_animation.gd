extends AnimatedSprite2D

@export var current_speed: float


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func set_animation_speed(speed):
	speed_scale = speed
	print(speed_scale)
