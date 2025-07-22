extends Camera2D


func _process(_delta: float) -> void:
		#KEEPS THE CAMERA IN CORRECT ORIENTATION TO THE TRAIN AND PARALLAX LAYERS
		global_position += Vector2(Global.locomotion, 0)
