extends Node2D
# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum {FIRST, SECOND}'
signal speed_increased
signal friction_applied
signal transition_intiated
signal stopped

@export var min_speed: float = 0
@export var cruising_speed: float = 5
@export var max_speed: float = 10

const FRICTION_VALUE: float = 0.2

var current_speed

func ready() -> void:
	current_speed = clamp(cruising_speed, min_speed, max_speed)

func process(delta: float) -> void:
	pass

func _cruise():
	if current_speed < cruising_speed:
		current_speed = cruising_speed
	_friction()

func _transitioning():
	pass

func _stopped():
	var tween = create_tween()
	tween.tween_property(self, "current_speed", 0.0, 18.0)

func _friction():
	current_speed -= FRICTION_VALUE
