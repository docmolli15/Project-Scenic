extends Button

var tunnelScene = preload("res://scenes/tunnel_transition.tscn")

#BUTTON FUNCTION TO CREATE TUNNEL SCENE FOR THE LANDSCAPE TO CHANGE
func _on_pressed() -> void:
	print("pressed")
	var newTunnel =tunnelScene.instantiate()
	add_child(newTunnel)
