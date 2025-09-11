extends Control

@onready var quitBox = %"Quit?"
@onready var speedGauge = %TextureProgressBar
@onready var steam = %steam
@onready var shop = %Tabs
@onready var stats_bar = %Stats
@onready var pop_up_timer = %Timer
@onready var collapse_button = %CollapseButton
@onready var tunnelFired = false

var tripOver = false
var is_collapsed = false
var tween: Tween = null
var is_tweening = false

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
	MessageBus.update_buttons.emit()

func shop_de_pop():
	shop.visible = false

func pop_up() -> void:
	shop.show_and_reset()

func collapse_menu() -> void:
	if is_tweening:
		return
	var start_position: Vector2
	var end_position: Vector2
	if is_collapsed:
		start_position = Vector2(-310, -73)
		end_position = Vector2(-310, -14)
	else:
		start_position = Vector2(-310, -14)
		end_position = Vector2(-310, -73)
	is_tweening = true
	tween = create_tween()
	tween.tween_property(stats_bar, "position", end_position, 0.25).from(start_position)
	tween.finished.connect(func():
		is_tweening = false
		is_collapsed = !is_collapsed
	)
