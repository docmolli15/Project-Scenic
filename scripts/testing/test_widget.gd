extends Node2D
#INSPECTOR ELEMENTS FOR TESTS
#THE LONGER THE TRIP, THE SMALLER THE TRIP LENGTH VARIABLE WILL BE
#BUTTONS FOR TESTS
func _ready():
	pass

func _on_station_pressed() -> void:
	MessageBus.stationStop.emit()


func _on_button_pressed():
	get_tree().quit()

func _on_option_button_item_selected(index):
	MessageBus.selectLandscape.emit(index)
	MessageBus.summonTunnel.emit()
	
	print(index)
