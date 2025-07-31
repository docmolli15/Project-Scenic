extends Node2D
#ADD ELEMENT TO THE INSPECTOR THAT WILL BE USED TO GOVERN THE SPEED OF THE LANDSCAPE AND TRAIN
@export var velocity: int
#VARIABLE TO ACCESS PROPERTIES OF THE PARALLAX2D NODES

func _ready() -> void:
	pass
	
func _process(_delta: float) -> void:
	animationSpeed()

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
