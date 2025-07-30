extends Button

func _on_pressed():
	#INCREASES SPEED OF THE TRAIN ANIMATION AND MOVEMENT OF PARALLAX LAYERS BY CHANGING THE GLOBAL VARIABLE
	if Global.tunnelLock == false:
		Global.locomotion += .25
