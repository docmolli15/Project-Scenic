extends Node2D
# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum {FIRST, SECOND}'
signal speed_adjusted(speed)

@onready var FrictionTimer = %FrictionTimer
@onready var CruiseTimer = %CruiseTimer

@export var min_speed: float = 0
@export var cruising_speed: float = 6
@export var current_speed: float
@export var max_speed: float = 15

const FRICTION_VALUE: float = 0.25
const COAL_VALUE: float = 1.0
const START_STOP_TIME: float = 15
const STATION_DEPART_SPEED = 10.0
const TUNNEL_TRANSITION_TIME = 5.0
const TUNNEL_TRANSITION_SPEED = 8.0

enum State {CRUISING, ARRIVING, DEPARTING, TRANSITIONING}

var current_train_state = State.CRUISING

func _ready() -> void:
	current_speed = max_speed
	switch_state(State.CRUISING)

func _process(_delta: float) -> void:
	print(current_speed)
	_update_speed()

func switch_state(state: State):
	match state:
		State.CRUISING:
			_cruise()
		State.ARRIVING:
			_arrive()
		State.DEPARTING:
			_depart()
		State.TRANSITIONING:
			_transition()

func _cruise():
	if State.CRUISING:
		current_speed -= FRICTION_VALUE
		current_speed = clamp(current_speed, cruising_speed, max_speed)
		CruiseTimer.start()

func _arrive():
	__tween_adjustment(min_speed, START_STOP_TIME)

func _depart():
	__tween_adjustment(STATION_DEPART_SPEED, START_STOP_TIME)
	
func _transition():
	__tween_adjustment(TUNNEL_TRANSITION_SPEED, TUNNEL_TRANSITION_TIME)

func __tween_adjustment(target_speed: float, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "current_speed", target_speed, duration)

func _update_speed() -> void:
	speed_adjusted.emit(current_speed)
	FrictionTimer.start()

func speed_up() -> void:
	current_speed += COAL_VALUE

func arrive() -> void:
	switch_state(State.ARRIVING)

func depart() -> void:
	switch_state(State.DEPARTING)

func transition() -> void:
	switch_state(State.TRANSITIONING)
