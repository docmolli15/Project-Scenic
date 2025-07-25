extends Button

#PLACEHOLDER FUNCTION FOR CHANGING LANDSCAPES
func _on_pressed() -> void:
	print("pushed")
	print(Global.frame)
	if Global.frame == 1:
		Global.frame = 2
	else:
		Global.frame = 1
	print(Global.frame)
