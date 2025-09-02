extends Node2D
# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum = {FIRST, SECOND}'

@onready var TrainAnim = %AnimatedSprite2D

@export var current_speed: float
var max_car_spaces: int = 12
var cars = []

const CAR_LOCATION_DATA= [
	Vector2(-38, 507), Vector2(-83, 507), 
	Vector2(-128, 507), Vector2(-173, 507), 
	Vector2(-218, 507), Vector2(-263, 507), 
	Vector2(-308, 507), Vector2(-353, 507),
	Vector2(-398, 507), Vector2(-443, 507), 
	Vector2(-488, 507), Vector2(-533, 507), 
	]

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	set_animation_speed()

func _on_speed_component_speed_adjusted(speed: Variant) -> void:
	current_speed = speed

func set_animation_speed():
	TrainAnim.speed_scale = current_speed

func trigger_station_ui(area):
	if area.name == "ShopTrigger":
		Global.current_station = Global.route_info["Station"]
		open_shop()

func open_shop():
	MessageBus.trigger_shop.emit()
	MessageBus.update_map_choices.emit()

func spawn_train_car(choice: String):
	if cars.size() >= max_car_spaces:
		print("Train is full. Cannot spawn more cars.")
	else:
		var train_car_scene: PackedScene = preload("res://scenes/player/train_car.tscn")
		var train_car: TrainCar = train_car_scene.instantiate()
		train_car.car_type = choice
		add_child(train_car)
