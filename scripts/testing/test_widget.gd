extends Node2D
#BUTTONS FOR TESTS
func _ready():
	pass

func _on_shovel_coal_pressed():
	MessageBus.shovelCoal.emit()
	print("pressed")

func _on_station_pressed() -> void:
	MessageBus.stationStop.emit()

func _on_tunnel_pressed():
	MessageBus.summonTunnel.emit()

func _on_button_pressed():
	get_tree().quit()
