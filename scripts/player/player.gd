extends Node2D

#ADD ELEMENTS TO THE INSPECTOR THAT WILL BE USED TO GOVERN THE SPEED OF THE LANDSCAPE AND TRAIN
@export var velocity: float
@export var friction_lock = false
@export var parked = false
#VARIABLES TO MANIPULATE THE TRAIN ANIMATION AND SMOKE
@onready var trainAnim = %AnimatedSprite2D
@onready var smokeStack = %GPUParticles2D
@onready var timer = %Timer
@onready var stationTimer = %StationTimer

func _ready() -> void:
	MessageBus.shovelCoal.connect(increaseSpeed)
	MessageBus.stationStop.connect(stop)
	friction()

func _process(_delta: float) -> void:
	trainAnimation()
	smoke()

func friction():
	if friction_lock == false:
		if velocity < 23.0 and velocity > 11.0:
			velocity -= 0.2
		elif velocity > 23.0:
			velocity = 22.0
		else:
			velocity = 11
	timer.start()

func increaseSpeed():
	if friction_lock == false:
		velocity += 1.0

func smoke():
	smokeStack.amount_ratio = velocity * 0.03
	smokeStack.process_material.gravity.x = velocity * -5

func trainAnimation():
	trainAnim.speed_scale = velocity * .18

func _on_timer_timeout() -> void:
	friction()

func stop():
	if parked == false:
		friction_lock = true
		var tween = create_tween()
		tween.tween_property(self, "velocity", 0.0, 18.0)
		parked = true
	else:
		parked = false
		var tween = create_tween()
		tween.tween_property(self, "velocity", 11.0, 18.0)
		stationTimer.start()
		friction_lock = false
