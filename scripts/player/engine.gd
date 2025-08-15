extends Node2D
# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum = {FIRST, SECOND}'

@onready var TrainAnim = %AnimatedSprite2D

@export var current_speed: float

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	set_animation_speed()

func _on_speed_component_speed_adjusted(speed: Variant) -> void:
	current_speed = speed

func set_animation_speed():
	TrainAnim.speed_scale = current_speed
