extends Node2D
#ELEMENT THAT WILL BE USED TO GOVERN THE SPEED OF THE LANDSCAPE AND TRAIN
@export var velocity: float
#ELEMENT FOR LOCKING VELOCITY
@export var friction_lock = false
@export var parked = false
@export var transitioning = false
@onready var timer = %Timer
@onready var stationTimer = %StationTimer
@onready var tunnelTimer = %TunnelTimer

func _ready() -> void:
	MessageBus.shovelCoal.connect(increaseSpeed)
	MessageBus.stationStop.connect(station)
	MessageBus.stationStop.connect(stop)
	MessageBus.summonTunnel.connect(createTunnel)
	friction()

func _process(_delta: float) -> void:
	animationSpeed()

func increaseSpeed():
	if friction_lock == false:
		velocity += 1.0

func friction():
	if friction_lock == false:
		if velocity < 28.0 and velocity > 16.0:
			velocity -= 0.2
		elif velocity > 28.0:
			velocity = 27.0
		else:
			velocity = 16.0
	timer.start()

func animationSpeed():
	#VARIABLE TO ACCESS PROPERTIES OF THE PARALLAX2D NODES
	var childrenNodes = get_children()
	#AUTOSCROLL VARIABLE THAT INCREASES AS FUNCTION ITERATES THROUGH LAYERS
	var base = -2
	for child in childrenNodes:
		#IDENTIFY CHILDREN OF THE WORLD NODE THAT ARE PARALLAX2DS
		if child is Parallax2D:
			#CONTROL SPEED THROUGH AUTOSCROLL
			child.autoscroll.x = base * velocity
			#INCREASE BASE WITH EACH LAYER
			base -= 2

func _on_timer_timeout() -> void:
	friction()

func stop():
	if parked == false:
		friction_lock = true
		var tween = create_tween()
		tween.tween_property(self, "velocity", 0.0, 18.0)
		stationTimer.start()
		parked = true
	else:
		parked = false
		var tween = create_tween()
		tween.tween_property(self, "velocity", 16.0, 18.0)
		stationTimer.start()
		friction_lock = false

func station():
	if parked == false:
		var parent_node = $POIs
		var stop_scene = preload("res://scenes/station.tscn")
		var new_station = stop_scene.instantiate()
		parent_node.add_child(new_station)
		new_station.global_position = Vector2(2000, 1060)
		var tween = get_tree().create_tween()
		tween.tween_property(new_station, "global_position", Vector2(960, 1060), 18.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	else:
		MessageBus.stationDelete.emit()

func createTunnel():
	if transitioning == false:
		transitioning = true
		friction_lock = true
		velocity = 20
		var parent_node = $POIs
		var tunnel = preload("res://scenes/tunnel.tscn")
		var new_tunnel = tunnel.instantiate()
		parent_node.add_child(new_tunnel)
		new_tunnel.global_position = Vector2(3300, 1020)
		var tween = get_tree().create_tween()
		tween.tween_property(new_tunnel, "global_position", Vector2(-2000, 1020), 32.0)
		tunnelTimer.start()

func _on_tunnel_timer_timeout():
	transitioning = false
	MessageBus.deleteTunnel.emit()
