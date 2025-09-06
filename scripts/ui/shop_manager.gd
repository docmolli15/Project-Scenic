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
@onready var buy_button = %Buy
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
	first_car = train_items[0] if train_items.size() > 0 else ShopDatabase.items["none"]
	second_car = train_items[1] if train_items.size() > 1 else ShopDatabase.items["none"]
	third_car = train_items[2] if train_items.size() > 2 else ShopDatabase.items["none"]

	first_upgrade = upgrade_items[0] if upgrade_items.size() > 0 else ShopDatabase.items["none"]
	second_upgrade = upgrade_items[1] if upgrade_items.size() > 1 else ShopDatabase.items["none"]
	third_upgrade = upgrade_items[2] if upgrade_items.size() > 2 else ShopDatabase.items["none"]
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

func _purchase() -> void:
	buy_focused_item()
	MessageBus.stats_updated.emit() 

func buy_focused_item():
	if focused_item.is_empty():
		return

	var price = focused_item.get("price", 0)
	if Global.funds < price:
		return

	var item_id = get_item_id(focused_item)
	if item_id == "":
		return

	Global.get_active_player_data().purchased_items[item_id] = true
	MessageBus.spent.emit(price)

	if focused_item.has("effect") and typeof(focused_item.effect) == TYPE_CALLABLE:
		focused_item.effect.call()

	if focused_item.get("type", "") == "train":
		MessageBus.train_purchased.emit(item_id)

	replace_focused_item_with_none()
	clear_focus()

func get_item_id(item: Dictionary) -> String:
	for key in ShopDatabase.items:
		if ShopDatabase.items[key] == item:
			return key
	return ""

func clear_focus():
	focused_item = {}
	focused_pic.frame = -1
	focused_name.text = ""
	focused_description.text = ""
	focused_price.text = ""

func replace_focused_item_with_none():
	var none_item = ShopDatabase.items["none"]

	if focused_item == first_car:
		first_car = none_item
		car1.frame = none_item["frame"]
	elif focused_item == second_car:
		second_car = none_item
		car2.frame = none_item["frame"]
	elif focused_item == third_car:
		third_car = none_item
		car3.frame = none_item["frame"]
	elif focused_item == first_upgrade:
		first_upgrade = none_item
		upgrade1.frame = none_item["frame"]
	elif focused_item == second_upgrade:
		second_upgrade = none_item
		upgrade2.frame = none_item["frame"]
	elif focused_item == third_upgrade:
		third_upgrade = none_item
		upgrade3.frame = none_item["frame"]
