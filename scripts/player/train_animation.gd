extends AnimatedSprite2D

@onready var trainAnim = %AnimatedSprite2D
@onready var frictionTimer = %Timer

func _ready():
		friction()

func _process(_delta):
			movement_speed()

func movement_speed():
	#TRAIN AINMATION SPEED CHANGED BY THE GLOBAL VARIABLE
	trainAnim.speed_scale = Global.locomotion
	
func friction():
	if Global.locomotion > .5 and Global.locomotion < 8:
		Global.locomotion -= .5
		frictionTimer.start()
		print(Global.locomotion)
	elif Global.locomotion >= 8:
		Global.locomotion = 7
		frictionTimer.start()
		print(Global.locomotion)
	else: 
		frictionTimer.start()
		print(Global.locomotion)

func _on_timer_timeout():
	friction()
