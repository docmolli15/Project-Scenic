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

@onready var update_timer = %UpdateTimer
@onready var cruise_timer = %CruiseTimer
@onready var tunnel_timer = %TunnelTimer
@onready var trip_timer = %TripTimer

@export var min_speed: float = 0.0
@export var cruising_speed: float = 8.0
@export var current_speed: float
@export var max_speed: float = 17.0

const FRICTION_VALUE: float = 0.05
const COAL_VALUE: float = 1.0
const START_STOP_TIME: float = 15
const STATION_DEPART_SPEED = 10.0
const TUNNEL_TRANSITION_TIME = 5.0
const TUNNEL_TRANSITION_SPEED = 8.0

enum State {CRUISING, ARRIVING, DEPARTING, TRANSITIONING}

var current_train_state = State.CRUISING

func _ready() -> void:
	MessageBus.departed_station.connect(depart)
	MessageBus.sped_up.connect(speed_up)
	MessageBus.back_to_cruise.connect(finished_transition)
	MessageBus.trip_timer_ends.connect(arrive)
	switch_state(State.CRUISING)

func _process(_delta: float) -> void:
	_update_speed()

func switch_state(state: State):
	current_train_state = state
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
	var friction_reducer = Global.get_active_player_data().dynamic_player_stats.get("friction reducer", 0.0)
	if current_train_state == State.CRUISING:
		current_speed -= (FRICTION_VALUE + friction_reducer)
		current_speed = clamp(current_speed, cruising_speed, max_speed)
		cruise_timer.start()

func _arrive():
	__tween_adjustment(min_speed, START_STOP_TIME)

func _depart():
	__tween_adjustment(STATION_DEPART_SPEED, START_STOP_TIME)
	
func _transition():
	__tween_adjustment(TUNNEL_TRANSITION_SPEED, TUNNEL_TRANSITION_TIME)

func __tween_adjustment(target_speed: float, duration: float):
	var tween = create_tween()
	tween.tween_property(self, "current_speed", target_speed, duration)
	if target_speed == STATION_DEPART_SPEED:
		tween.finished.connect(departed, CONNECT_ONE_SHOT)
	if target_speed == TUNNEL_TRANSITION_SPEED:
		tween.finished.connect(tunnel_timer.start, CONNECT_ONE_SHOT)

func departed():
	switch_state(State.CRUISING)

func transitioned() -> void:
	switch_state(State.TRANSITIONING)

func finished_transition():
	switch_state(State.CRUISING)

func _update_speed() -> void:
	Global.current_speed = current_speed
	speed_adjusted.emit(current_speed)
	update_timer.start()

func speed_up() -> void:
	if current_train_state == 0 and Global.funds > 0 and current_speed < (max_speed - 1.0):
		MessageBus.spent.emit(5)
		current_speed += COAL_VALUE

func arrive() -> void:
	switch_state(State.ARRIVING)
	MessageBus.arrived_at_station.emit()

func depart() -> void:
	switch_state(State.DEPARTING)
	trip_timer.duration = Global.route_info['Duration']
	trip_timer.start_timer(
	Global.route_info["Duration"],
	Global.route_info["Tunnel Triggers"],
	Global.route_info["Frames"]
)

func transition(index) -> void:
	switch_state(State.TRANSITIONING)
	MessageBus.tunnelled_through.emit(index)

func add_funds() -> void:
	MessageBus.acquired.emit(100000)
	print(Global.trip_progress)
