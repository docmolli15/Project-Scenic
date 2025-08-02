extends Node2D
#ELEMENT THAT WILL BE USED TO GOVERN THE SPEED OF THE LANDSCAPE AND TRAIN
@export var velocity: float
#ELEMENT TO KEEP TRACK OF DIFFERENT STAGES; TRAIN RUNNING, STOPPED, IN A TUNNEL
@export var friction_lock = false
@export var parked = false
@export var transitioning = false
#VARIABLE FOR ANIMATION FRAME OF ALL BACKGROUNDS
@export var landscapeFrame: int
#IMPORTANT TIMERS FOR MEASURING FRICTION,SELECTING LANDSCAPES AND DELETING TUNNELS
@onready var frictionTimer = %FrictionTimer
@onready var landscapeTimer = %LandscapeTimer
@onready var tunnelTimer = %TunnelTimer

#INCOMING SIGNALS
func _ready() -> void:
	MessageBus.shovelCoal.connect(increaseSpeed)
	MessageBus.stationStop.connect(station)
	MessageBus.stationStop.connect(stop)
	MessageBus.summonTunnel.connect(createTunnel)
	MessageBus.selectLandscape.connect(landscapeTimerStart)
	friction()

func _process(_delta: float) -> void:
	animationSpeed()
	velocityCheck()

#CHECKS THE CURRENT VELOCITY AND SENDS UPDATE TO THE UI SPEED GUAGE
func velocityCheck():
	MessageBus.updateSpeedGauge.emit(velocity)
	
#FUNCTION ACTIVATED BY SHOVELING COAL
func increaseSpeed():
	if friction_lock == false:
		velocity += 0.2

#FUNCTION THAT SLOWS THE TERRAIN WHEN RUNNING
func friction():
	#IF VARIABLE IS FALSE
	if friction_lock == false:
		#KEEPS SPEED WITHIN A CERTAIN RANGE
		if velocity < 28.0 and velocity > 16.0:
			velocity -= 0.2
			#CEILING TO THE SPEED, CORRECTED IF COAL SHOVELING PUTS SPEED OUTSIDE RANGE
		elif velocity > 28.0:
			velocity = 27.0
			#MINIMUM SPEED WHEN TRAIN IS RUNNING
		else:
			velocity = 16.0
	frictionTimer.start()

#KEEPS ANIMATION OF THE TRAIN AT SPEED PROPORTIONAL TO THE LANDSCAPE
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

#PERIODICALLY APPLYING FRICTION
func _on_timer_timeout() -> void:
	friction()

#STOPPING TERRAIN AT THE SPAWNED STATION
func stop():
	if parked == false:
		friction_lock = true
		#USE TWEEN TO SLOW THE TERRAIN TO A STOP
		var tween = create_tween()
		tween.tween_property(self, "velocity", 0.0, 18.0)
		parked = true
	else:
		parked = false
		#USE TWEEN TO LEAVE THE STATION
		var tween = create_tween()
		tween.tween_property(self, "velocity", 16.0, 18.0)
		friction_lock = false

#SPAWN STATION
func station(): 
	#IF THE TRAIN ISN'T ALREADY AT A STATION
	if parked == false:
		#SPAWN A STATION AS A CHILD OF POIs
		var parent_node = $POIs
		var stop_scene = preload("res://scenes/station.tscn")
		var new_station = stop_scene.instantiate()
		parent_node.add_child(new_station)
		#POSITION IT OUTSIDE OF THE CAMERA'S RIGHT BORDER AND MOVE IT IN TO KEEP PACE WITH THE SLOWING PARALLAX
		new_station.global_position = Vector2(2000, 1060)
		var tween = get_tree().create_tween()
		tween.tween_property(new_station, "global_position", Vector2(960, 1060), 18.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	else:
	#IF ALREADY AT A STATION, TRIGGER THE PROCESS OF LEAVING AND DELETING THE STATION
		MessageBus.stationDelete.emit()

#SPAWN TUNNEL
func createTunnel():
	#LOCK AT SLIGHTER HIGHER THAN SLOWEST SPEED TO FACILITATE TRANSITION
	if transitioning == false:
		transitioning = true
		friction_lock = true
		velocity = 20
		#SPAWN TUNNEL AS CHILD OF POIs OUTSIDE OF RIGHT CAMERA BOUNDARY
		var parent_node = $POIs
		var tunnel = preload("res://scenes/tunnel.tscn")
		var new_tunnel = tunnel.instantiate()
		parent_node.add_child(new_tunnel)
		new_tunnel.global_position = Vector2(3300, 1020)
		#USE TWEEN TO PASS TUNNEL THROUGH THE SCENE AT SAME SPEED AS PARALLAX
		var tween = get_tree().create_tween()
		tween.tween_property(new_tunnel, "global_position", Vector2(-2000, 1020), 32.0)
		tunnelTimer.start()

#TIMER TO TRIGGER DELETING OF TUNNEL
func _on_tunnel_timer_timeout():
	transitioning = false
	friction_lock = false
	MessageBus.deleteTunnel.emit()

#START LANDSCAPE TIMER
func landscapeTimerStart(index):
	#SET THE INCOMING LANDSCAPE FRAMES
	landscapeFrame = index
	#START A TIMER TO COINCIDE WITH THE TUNNEL OBSCURING THE SCENE
	landscapeTimer.start()

#CHANGE FRAMES OF BACKGROUNDS TO SELECTED LANDSCAPE
func _on_landscape_timer_timeout() -> void:
	#ITERATE THROUGH THE ENTIRE TREE TO FIND ALL SPRITE2D NODES
	for node in self.find_children("*", "AnimatedSprite2D", true, false):
		if node is AnimatedSprite2D:
			#SET THE SPRITES TO THE INCOMING FRAMES
			node.frame = landscapeFrame
