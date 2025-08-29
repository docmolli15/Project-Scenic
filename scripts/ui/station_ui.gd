extends Control

@onready var route_manager = %"RouteManager"
@onready var shop_manager = %"ShopManager"
@onready var manifest_manager = %"ManifestManager"
@onready var route_button = %RouteTab
@onready var shop_button = %ShopTab
@onready var manifest_button = %ManifestTab
@onready var confirm_button = %ConfirmTab
@onready var confirm_panel = %ConfirmPanel
@onready var tooltip = %Tooltip
@onready var tool_timer = %TooltipTimer

func _ready():
	for button in [route_button, shop_button, manifest_button, confirm_button]:
		button.toggle_mode = true
		button.pressed.connect(_on_tab_pressed.bind(button))  

	_set_tab(route_button, route_manager)

func show_and_reset():
	_set_tab(route_button, route_manager)
	self.visible = true

func _on_tab_pressed(button):
	if button == route_button:
		_set_tab(route_button, route_manager)
	elif button == shop_button:
		_set_tab(shop_button, shop_manager)
	elif button == manifest_button:
		_set_tab(manifest_button, manifest_manager)
	elif button == confirm_button:
		_set_tab(confirm_button, confirm_panel)

func _set_tab(active_button, visible_manager):
	for manager in [route_manager, shop_manager, manifest_manager, confirm_panel]:
		if manager: manager.visible = (manager == visible_manager)
	for button in [route_button, shop_button, manifest_button, confirm_button]:
		button.button_pressed = (button == active_button)

func finished_shopping():
	if route_manager.destination_chosen == true:
		MessageBus.finished_shopping.emit()
		MessageBus.departed_station.emit()
		route_manager.destination_chosen = false
	else:
		tooltip.visible = true
		tool_timer.start()

func depop_tooltip() -> void:
	tooltip.visible = false
