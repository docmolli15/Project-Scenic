extends Node

var items := {
	"none": {
		"name": "OUT OF STOCK",
		"type": "train",
		"price": 0,
		"frame": 0,
		"description": "Sorry, all out of stock.",
		"effect": "none",
		"tier": "none",
		"unique": false
	},
	"box": {
		"name": "Boxcar",
		"type": "train",
		"price": 500,
		"frame": 1,
		"description": "A large train car for moving freight. Carry some basic packages.",
		"effect": func(): pass,
		"tier": 1,
		"unique": false
	},
	"caboose": {
		"name": "Caboose",
		"type": "train",
		"price": 1200,
		"frame": 2,
		"description": "No train is complete without a caboose. More employees per car.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"luxury": {
		"name": "Luxury Car",
		"type": "train",
		"price": 5000,
		"frame": 3,
		"description": "A fancy car that hosts entertainment and cozy seating. Dramatically increase the money earned from trasnporting passengers.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": false
	},
	"passenger": {
		"name": "Passenger Car",
		"type": "train",
		"price": 1000,
		"frame": 4,
		"description": "A basic car with rooms. Increase passenger capacity by 2.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": false
	},
	"coal": {
		"name": "Coal Car",
		"type": "train",
		"price": 1000,
		"frame": 5,
		"description": "Comes with a Stoker. No more shoveling your own coal.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": false
	},
	"coffee_bar": {
		"name": "Coffee Bar",
		"type": "upgrade",
		"price": 25000,
		"frame": 6,
		"description": "A classy refreshment bar that improves the luxury car, doubling money earned.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"dining_service": {
		"name": "Dining Services",
		"type": "upgrade",
		"price": 15000,
		"frame": 7,
		"description": "Food services, periodically adding funds from passenger purchases.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"delicate_item_storage": {
		"name": "Delicate Item Storage",
		"type": "upgrade",
		"price": 25000,
		"frame": 8,
		"description": "Equipment for boxcars to transport items normally too delicate for traveling on trains.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"employee_capacity": {
		"name": "Increased Caboose Capacity",
		"type": "upgrade",
		"price": 75000,
		"frame": 9,
		"description": "The caboose can hold double the employees, allowing for more cars to operate at maximum efficiency.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"engine_upgrade_1": {
		"name": "Engine Upgrade I",
		"type": "upgrade",
		"price": 10000,
		"frame": 10,
		"description": "A much needed upgrade for your engine, making it burn coal more efficiently. Price of shoveling coal reduced to $2.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"engine_upgrade_2": {
		"name": "Engine Upgrade II",
		"type": "upgrade",
		"price": 25000,
		"frame": 11,
		"description": "Speed from shoveled coal will drop slower, making the most out of the speed increase.",
		"effect": "func(): pass",
		"tier": 2,
		"unique": true
	},
	"engine_upgrade_3": {
		"name": "Engine Upgrade III",
		"type": "upgrade",
		"price": 100000,
		"frame": 12,
		"description": "Maximum speed achievable by your engine is significantly increased.",
		"effect": "func(): pass",
		"tier": 3,
		"unique": true
	},
	"engine_upgrade_4": {
		"name": "Engine Upgrade IV",
		"type": "upgrade",
		"price": 250000,
		"frame": 13,
		"description": "Maximum speed increased, speed drops even slower, and cost of shoveling reduced to $1. What peak efficiency looks like.",
		"effect": "func(): pass",
		"tier": 4,
		"unique": true
	},
	"passenger_car_upgrade": {
		"name": "Passenger Car Refit",
		"type": "upgrade",
		"price": 75000,
		"frame": 14,
		"description": "Carry more passengers and earn slightly more money from them.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"coal_car_upgrade": {
		"name": "Coal Car Upgrade",
		"type": "upgrade",
		"price": 75000,
		"frame": 15,
		"description": "Hire two Stokers per coal car. Satisfy your need for speed.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"luxury_car_upgrade": {
		"name": "Luxury Renovations",
		"type": "upgrade",
		"price": 150000,
		"frame": 16,
		"description": "An even classier experience, increasing money earned per passenger.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"caboose_upgrade": {
		"name": "Captivating Caboose ",
		"type": "upgrade",
		"price": 250000,
		"frame": 17,
		"description": "Better facilities lead to reduced cost per employee. Don't worry, wages aren't negatively affected.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
	"boxcar_upgrade": {
		"name": "Bigger Boxcars",
		"type": "upgrade",
		"price": 75000,
		"frame": 18,
		"description": "Doubles the capacity of freight that can be transported.",
		"effect": "func(): pass",
		"tier": 1,
		"unique": true
	},
}

func _ready() -> void:
	pass

func get_items_by_filter(type_filter: String, tier_filter: Variant = null, exclude_keys: Array = []) -> Array:
	var result := []
	for key in items:
		if key == "none":
			continue
		if key in exclude_keys:
			continue

		var item = items[key]

		if item["type"] != type_filter:
			continue

		if tier_filter != null and item.get("tier", null) != tier_filter:
			continue

		result.append(item)

	return result
