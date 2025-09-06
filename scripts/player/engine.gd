extends Node2D
# This is a comment
#Disabled Code
## This is a documentation comment

# Functions, files, variables get snake_case like 'file_name.tres' 'my_function' 'my_variable'
# Signals also snake_case but also past tense verb 'signal_passed'
# Classes and nodes get PascalCase like 'MyNode'
# Constants use CONSTANT_CASE
# Enum us PascalCase for name but CONSTANT_CASE for members 'MyEnum = {FIRST, SECOND}'
signal animation_frame_synced(frame: int)

@onready var TrainAnim = %AnimatedSprite2D

@export var current_speed: float
var max_car_spaces: int = 12
var cars = []
var last_sent_speed: float = -1.0

const CAR_LOCATION_DATA= [
	Vector2(-38, 510), Vector2(-83, 510), 
	Vector2(-128, 510), Vector2(-173, 510), 
	Vector2(-218, 510), Vector2(-263, 510), 
	Vector2(-308, 510), Vector2(-353, 510),
	Vector2(-398, 510), Vector2(-443, 510), 
	Vector2(-488, 510), Vector2(-533, 510), 
	]

func _ready() -> void:
	MessageBus.train_purchased.connect(spawn_train_car)

func _process(_delta: float) -> void:
	set_animation_speed()
	animation_frame_synced.emit(TrainAnim.frame)

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
	MessageBus.update_shop.emit()

func spawn_train_car(item_id: String):
	var item_data = ShopDatabase.items.get(item_id, null)
	if item_data == null:
		push_error("Train item ID not found: " + item_id)
		return

	if item_id == "caboose":
		for car in cars:
			if car.car_type == "caboose":
				return

	if cars.size() >= max_car_spaces:
		return

	var train_car_scene: PackedScene = preload("res://scenes/player/train_car.tscn")
	var train_car: TrainCar = train_car_scene.instantiate()
	train_car.car_type = item_id

	if item_id == "caboose":
		cars.append(train_car)
	else:
		var caboose_index := -1
		for i in cars.size():
			if cars[i].car_type == "caboose":
				caboose_index = i
				break
		if caboose_index != -1:
			cars.insert(caboose_index, train_car)
		else:
			cars.append(train_car)

	add_child(train_car)
	recalculate_car_positions()

func recalculate_car_positions():
	var caboose: TrainCar = null
	for car in cars:
		if car.car_type == "caboose":
			caboose = car
			break

	if caboose != null:
		cars.erase(caboose)

	for i in cars.size():
		var car = cars[i]
		car.array_position = i
		var tween = create_tween()
		tween.tween_property(car, "position", CAR_LOCATION_DATA[i], 0.5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)

	if caboose != null:
		var index := cars.size()
		caboose.array_position = index
		var tween = create_tween()
		tween.tween_property(caboose, "position", CAR_LOCATION_DATA[index], 0.5).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
		cars.append(caboose)

func _on_coal_pressed() -> void:
	spawn_train_car("coal")

func _on_box_pressed() -> void:
	spawn_train_car("box")

func _on_luxury_pressed() -> void:
	spawn_train_car("luxury")

func _on_caboose_pressed() -> void:
	spawn_train_car("caboose")

func _on_passenger_pressed() -> void:
	spawn_train_car("passenger")
