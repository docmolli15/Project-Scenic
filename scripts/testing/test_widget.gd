extends Node2D

func _ready():
	pass

func _on_shovel_coal_pressed():
	MessageBus.shovelCoal.emit()
	print("pressed")

func _on_station_pressed() -> void:
	MessageBus.stationStop.emit()

func _on_tunnel_pressed():
	MessageBus.summonTunnel.emit()
