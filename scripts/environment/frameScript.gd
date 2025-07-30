extends ParallaxBackground

#FUNCTION TO CHANGE AND KEEP EACH FRAME OF THE PARRALAX BACKGROUNDS CONSISTENT
func _physics_process(delta: float) -> void:
	get_node("ParallaxLayer/Sprite2D").frame = Global.frame
