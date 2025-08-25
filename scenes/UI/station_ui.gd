extends Control

@onready var route_manager = %"Route Manager"
@onready var shop_manager = %"Shop Manager"
@onready var manifest_manager = %"Manifest Manager"

func _ready():
	$TextureButton.grab_focus()

func maps_pressed():
	route_manager.visible = true
	shop_manager.visible = false
	manifest_manager.visible = false

func shop_pressed():
	route_manager.visible = false
	shop_manager.visible = true
	manifest_manager.visible = false

func manifest_pressed():
	route_manager.visible = false
	shop_manager.visible = false
	manifest_manager.visible = true

func confirm_pressed():
	pass
