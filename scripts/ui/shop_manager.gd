extends Control

@onready var car1 = %Car1
@onready var car2 = %Car2
@onready var car3 = %Car3

func _ready():
	MessageBus.update_shop.connect(populate_shelves)

func populate_shelves():
	pass

func _car_one_pressed():
	pass

func _car_two_pressed():
	pass

func _car_three_pressed():
	pass
