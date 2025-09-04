extends Control

@onready var car1 = %Car1
@onready var car2 = %Car2
@onready var car3 = %Car3
@onready var upgrade1 = %UpgradeOne
@onready var upgrade2 = %UpgradeTwo
@onready var upgrade3 = %UpgradeThree
@onready var focused_pic = %FocusFrame
@onready var focused_name = %ItemName
@onready var focused_description = %Description
@onready var focused_price = %Price
var first_car = {}
var second_car = {}
var third_car = {}
var first_upgrade = {}
var second_upgrade = {}
var third_upgrade = {}
var focused_item = {}

func _ready():
	
	MessageBus.update_shop.connect(populate_shelves)

func populate_shelves():
	var data = Global.get_active_player_data()
	var exclude_keys: Array = []
	for key in data.purchased_items:
		if data.purchased_items[key]:
			exclude_keys.append(key)
	var train_items = ShopDatabase.get_items_by_filter("train", null, exclude_keys) 
	var upgrade_items = ShopDatabase.get_items_by_filter("upgrade", 1, exclude_keys)
	train_items.shuffle()
	upgrade_items.shuffle()
	first_car = train_items[0] if train_items.size() > 0 else ShopDatabase.ITEMS["none"]
	second_car = train_items[1] if train_items.size() > 1 else ShopDatabase.ITEMS["none"]
	third_car = train_items[2] if train_items.size() > 2 else ShopDatabase.ITEMS["none"]

	first_upgrade = upgrade_items[0] if upgrade_items.size() > 0 else ShopDatabase.ITEMS["none"]
	second_upgrade = upgrade_items[1] if upgrade_items.size() > 1 else ShopDatabase.ITEMS["none"]
	third_upgrade = upgrade_items[2] if upgrade_items.size() > 2 else ShopDatabase.ITEMS["none"]
	car1.frame = first_car["frame"]
	car2.frame = second_car["frame"]
	car3.frame = third_car["frame"]

	upgrade1.frame = first_upgrade["frame"]
	upgrade2.frame = second_upgrade["frame"]
	upgrade3.frame = third_upgrade["frame"]

func _car_one_pressed():
	focus_item(first_car)

func _car_two_pressed():
	focus_item(second_car)

func _car_three_pressed():
	focus_item(third_car)

func _upgrade_one_pressed() -> void:
	focus_item(first_upgrade)

func _upgrade_two_pressed() -> void:
	focus_item(second_upgrade)

func _upgrade_three_pressed() -> void:
	focus_item(third_upgrade)

func focus_item(item: Dictionary):
	focused_item = item
	focused_pic.frame = item["frame"]
	focused_name.text = item["name"]
	focused_description.text = item["description"]
	focused_price.text = str(item["price"])
