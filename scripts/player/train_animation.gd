extends Node2D

@onready var trainAnim = %AnimatedSprite2D
@onready var frictionTimer = %Timer
@onready var smokeStack = %GPUParticles2D

func _ready():
	friction()

func _process(_delta):
	movement_speed()

func movement_speed():
	#SET SPEED OF SPRITE MOVEMENT LEFT TO RIGHT BASED ON THE GLOBAL LOCOMOTION VARIABLE
	position.x += Global.locomotion

	#TRAIN AINMATION SPEED CHANGED BY THE GLOBAL VARIABLE
	trainAnim.speed_scale = Global.locomotion
	
func friction():
	#INCREASES OR DECREASES SMOKE FROM GPUPARTICLES2D NODE ACCORDING TO THE GLOBAL LOCOMOTION VARIABLE
	smokeStack.amount_ratio = Global.locomotion * 2
	#CHECKS CURRENT SPEED OF THE TRAIN ANIMATION, IF WITHIN RANGE IT SLOWLY REDUCES...
	if Global.locomotion > .5 and Global.locomotion < 5:
		Global.locomotion -= .25
		frictionTimer.start()
		print(Global.locomotion)
	elif Global.locomotion >= 5:
	#IF ABOVE RANGE, IMMEDIATELY LOWERED TO MAXIMUM RANGE
		Global.locomotion = 4
		frictionTimer.start()
		print(Global.locomotion)
	else: 
	#OTHERWISE NOTHING HAPPENS AND FUNCTION IS ACTIVATED TO CHECK AGAIN AT THE END OF THE TIMER
		frictionTimer.start()
		print(Global.locomotion)

#TIMER FUNCTION THAT KEEPS THE SPEED DROPPING OVER TIME
func _on_timer_timeout():
	friction()
