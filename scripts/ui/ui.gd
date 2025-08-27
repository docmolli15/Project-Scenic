extends Control

@onready var quitBox = %"Quit?"
@onready var speedGauge = %TextureProgressBar
@onready var steam = %steam
@onready var shop = %Tabs
@onready var pop_up_timer = %Timer
@onready var tunnelFired = false

var tripOver = false

func _ready() -> void:
	MessageBus.trigger_shop.connect(shop_pop_up)
	MessageBus.finished_shopping.connect(shop_de_pop)


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

func shop_pop_up():
	pop_up_timer.start()

func shop_de_pop():
	shop.visible = false

func pop_up() -> void:
	shop.visible = true
