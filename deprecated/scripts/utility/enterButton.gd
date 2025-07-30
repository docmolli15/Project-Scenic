extends Button

#BUTTON FUNCTION TO CREATE TUNNEL SCENE FOR THE LANDSCAPE TO CHANGE
func _on_pressed() -> void:
	print("pressed")
	if Global.tunnelLock == false:
		MessageBus.tunnelTransition.emit()
