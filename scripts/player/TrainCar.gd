class_name TrainCar extends Node2D


# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum = {FIRST, SECOND}'

@onready var TrainAnim = %AnimatedSprite2D
@onready var SmokeStack = %GPUParticles2D

@export var current_speed: float

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	set_animation_speed()

func _on_speed_component_speed_adjusted(speed: Variant) -> void:
	current_speed = speed

func set_animation_speed():
	TrainAnim.speed_scale = current_speed
	print(TrainAnim.speed_scale)

#func smoke():
	#SmokeStack.amount_ratio = current_speed * 0.1
	#SmokeStack.process_material.gravity.x = current_speed * -15

#PERIODICALLY APPLYING FRICTION
#func _on_timer_timeout() -> void:
	#friction()

#STOPPING TERRAIN AT THE SPAWNED STATION
#func stop():
	#if parked == false:
		#friction_lock = true
		#USE TWEEN TO SLOW THE TRAIN TO A STOP
		#var tween = create_tween()
		#FIRE SIGNAL TO UPDATE PLAYER LOCATION ON THE MAP
		#MessageBus.updatePlayerLocation.emit()
		#tween.tween_property(self, "velocity", 0.0, 18.0)
		#parked = true
	#else:
		#parked = false
		#USE TWEEN TO LEAVE THE STATION
		#var tween = create_tween()
		#tween.tween_property(self, "velocity", 11.0, 18.0)
		#stationTimer.start()
		#friction_lock = false


func _on_button_pressed() -> void:
	current_speed += 2.0
