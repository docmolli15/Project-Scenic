extends Node2D
#VARIABLE FOR POP-UP ASKING IF PLAYER IS SURE ABOUT QUITTING
@onready var controlBox = %VBoxContainer
@onready var quitBox = %Sprite2D
#SPEED GUAGE VARIABLE & MAX SPEED ART
@onready var speedGauge = %TextureProgressBar
@onready var steam = %steam
#MAP VARIABLE
@onready var map = %map
#VARIABLE TRACKING WHETHER OR NOT THE MAP IS OPEN
var mapOpen = false

func _ready() -> void:
	MessageBus.updateSpeedGauge.connect(updateSpeedValue)

#UPDATE THE VALUE WITHIN THE SPEED GAUGE
func updateSpeedValue(velocity):
	speedGauge.value = velocity
	if speedGauge.value >= (speedGauge.max_value - 1.0):
		steam.visible = true
	else:
		steam.visible = false

#SHOVEL COAL BUTTON FOR INCREASING SPEED
func _on_shovel_coal_pressed() -> void:
	MessageBus.shovelCoal.emit()

#EXIT BUTTON
func _on_quit_pressed() -> void:
	map.visible = false
	controlBox.visible = false
	quitBox.visible = true

#QUIT
func _on_yes_pressed() -> void:
	get_tree().quit()

#GO BACK
func _on_no_pressed() -> void:
	controlBox.visible = true
	quitBox.visible = false

#OPENING AND CLOSING THE MAP
func _on_map_icon_pressed() -> void:
	if mapOpen == false:
		mapOpen = true
		map.visible = true
	else:
		mapOpen = false
		map.visible = false
