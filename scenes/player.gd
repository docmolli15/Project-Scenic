extends Node2D

#ADD ELEMENT TO THE INSPECTOR THAT WILL BE USED TO GOVERN THE SPEED OF THE LANDSCAPE AND TRAIN
@export var velocity: int
#VARIABLES TO MANIPULATE THE TRAIN ANIMATION AND SMOKE
@onready var trainAnim = %AnimatedSprite2D
@onready var smokeStack = %GPUParticles2D

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	trainAnimation()
	smoke()

func smoke():
	smokeStack.amount_ratio = velocity * 0.03
	smokeStack.process_material.gravity.x = velocity * -5

func trainAnimation():
	trainAnim.speed_scale = velocity * .12
