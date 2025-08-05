extends Node2D

# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum = {FIRST, SECOND}'

enum TrainState {CRUISING, TRANSITIONING, STOPPED}

func switch_state(state: TrainState):
	match state:
		TrainState.CRUISING:
			pass
		TrainState.TRANSITIONING:
			pass
		TrainState.STOPPED:
			pass

func _cruising():
	pass

func _transitioning():
	pass

func _stopped():
	pass

#@export var velocity: float
#@export var friction_lock = false
#@export var parked = false

#@onready var trainAnim = %AnimatedSprite2D
#@onready var smokeStack = %GPUParticles2D
#@onready var timer = %Timer
#@onready var stationTimer = %StationTimer

#func _ready() -> void:
	#MessageBus.shovelCoal.connect(increaseSpeed)
	#MessageBus.stationStop.connect(stop)
	#friction()

#func _process(_delta: float) -> void:
	#trainAnimation()
	#smoke()


#FUNCTION THAT SLOWS THE TRAIN WHEN RUNNING
#func friction():
	#if friction_lock == false:
		#if velocity < 23.0 and velocity > 11.0:
			#velocity -= 0.2
		#elif velocity > 23.0:
			#velocity = 22.0
		#else:
			#velocity = 11
	#timer.start()

#FUNCTION ACTIVATED BY SHOVELING COAL
#func increaseSpeed():
	#if friction_lock == false:
		#velocity += 1.0

#INCREASE THE SMOKE GENERATION AND PUSHES THE SMOKE FURTHER BEHIND THE TRAIN AS SPEED INCREASES
#func smoke():
	#smokeStack.amount_ratio = velocity * 0.1
	#smokeStack.process_material.gravity.x = velocity * -15

#INCREASES SPEED OF ANIMATION AS THE TRAIN SPEEDS UP
#func trainAnimation():
	#trainAnim.speed_scale = velocity * .18

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
