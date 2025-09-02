extends AnimatedSprite2D

@onready var TrainAnim = %AnimatedSprite2D

@export var current_speed: float

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	set_animation_speed()

func set_animation_speed():
	TrainAnim.speed_scale = Global.current_speed
