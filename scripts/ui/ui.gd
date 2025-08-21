extends Control

@onready var quitBox = %"Quit?"
@onready var speedGauge = %TextureProgressBar
@onready var steam = %steam
@onready var tunnelFired = false

var tripOver = false

func _ready() -> void:
	pass


func _process(_delta):
	update_speed_value()

func update_speed_value():
	speedGauge.value = Global.current_speed
	if speedGauge.value >= (speedGauge.max_value - 1.0):
		steam.visible = true
	else:
		steam.visible = false

func _on_shovel_coal_pressed() -> void:
	MessageBus.sped_up.emit()

func _on_quit_pressed() -> void:
	quitBox.visible = true

func _on_yes_pressed() -> void:
	get_tree().quit()

func _on_no_pressed() -> void:
	quitBox.visible = false
