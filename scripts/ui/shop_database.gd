extends Node

const ITEMS := {
	"none": {
		"name": "OUT OF STOCK",
		"type": "train",
		"price": 0,
		"frame": 0,
		"description": "Sorry, all out of stock. We'll have some more by your next visit.",
		"effect": "none",
		"tier": "none"
	},
	"boxcar": {
		"name": "Boxcar",
		"type": "train",
		"price": 500,
		"frame": 1,
		"description": "A large train car for moving freight. Carrying capacity for packages increased.",
		"effect": "func(): pass",
		"tier": 1
	},
	"caboose": {
		"name": "Caboose",
		"type": "train",
		"price": 1200,
		"frame": 2,
		"description": "The employee car. Determines how many crew can work on your train.",
		"effect": "func(): pass",
		"tier": 1
	},
	"luxury_car": {
		"name": "Luxury Car",
		"type": "train",
		"price": 5000,
		"frame": 3,
		"description": "A fancy car that hosts entertainment and cozy seating. Dramatically increase the money earned from trasnporting passengers.",
		"effect": "func(): pass",
		"tier": 1
	},
	"passenger_car": {
		"name": "Passenger Car",
		"type": "train",
		"price": 1000,
		"frame": 4,
		"description": "A basic car with rooms. Increases the number of passengers you can take.",
		"effect": "func(): pass",
		"tier": 1
	},
	"coal_car": {
		"name": "Coal Car",
		"type": "train",
		"price": 1000,
		"frame": 5,
		"description": "Allows the hiring of a Stoker, shoveling the coal for you once every 30 seconds.",
		"effect": "func(): pass",
		"tier": 1
	},
	"coffee_bar": {
		"name": "Coffee Bar",
		"type": "upgrade",
		"price": 25000,
		"frame": 6,
		"description": "A classy refreshment bar that increases the effect of the luxury cars on money earned from passengers. The white chocolate mocha is divine.",
		"effect": "func(): pass",
		"tier": 1
	},
	"dining_service": {
		"name": "Dining Services",
		"type": "upgrade",
		"price": 15000,
		"frame": 7,
		"description": "Food services for passengers. Periodically adding funds from food purchased, earning more money across longer trips. Best item on the menu is the mac and cheese.",
		"effect": "func(): pass",
		"tier": 1
	},
	"delicate_item_storage": {
		"name": "Delicate Item Storage",
		"type": "upgrade",
		"price": 25000,
		"frame": 8,
		"description": "Equipment for boxcars to transport items normally too delicate for traveling on trains. Increases the variety of items that can be tranposrted.",
		"effect": "func(): pass",
		"tier": 1
	},
	"employee_capacity": {
		"name": "Increased Caboose Capacity",
		"type": "upgrade",
		"price": 75000,
		"frame": 9,
		"description": "The caboose can hold a much higher amount of employees, allowing for more cars to operate at maximum efficiency.",
		"effect": "func(): pass",
		"tier": 1
	},
	"engine_upgrade_1": {
		"name": "Engine Upgrade I",
		"type": "upgrade",
		"price": 10000,
		"frame": 10,
		"description": "A much needed upgrade for your engine, making it burn coal more efficiently. Price of shoveling coal reduced to $2.",
		"effect": "func(): pass",
		"tier": 1
	},
	"engine_upgrade_2": {
		"name": "Engine Upgrade II",
		"type": "upgrade",
		"price": 25000,
		"frame": 11,
		"description": "Speed from shoveled coal will drop slower, making the most out of the speed increase.",
		"effect": "func(): pass",
		"tier": 2
	},
	"engine_upgrade_3": {
		"name": "Engine Upgrade III",
		"type": "upgrade",
		"price": 100000,
		"frame": 12,
		"description": "Maximum speed achievable by your engine is significantly increased.",
		"effect": "func(): pass",
		"tier": 3
	},
	"engine_upgrade_4": {
		"name": "Engine Upgrade IV",
		"type": "upgrade",
		"price": 250000,
		"frame": 13,
		"description": "Maximum speed is increased again, speed drops even slower, and the cost of shoveling reduced to $1. This is what peak efficiency looks like.",
		"effect": "func(): pass",
		"tier": 4
	},
	"passenger_car_upgrade": {
		"name": "Passenger Car Refit",
		"type": "upgrade",
		"price": 75000,
		"frame": 14,
		"description": "Carry more passengers and earn slightly more money from them.",
		"effect": "func(): pass",
		"tier": 1
	},
	"coal_car_upgrade": {
		"name": "name",
		"type": "upgrade",
		"price": 75000,
		"frame": 15,
		"description": "Hire two Stokers per coal car. They have the need for speed.",
		"effect": "func(): pass",
		"tier": 1
	},
	"luxury_car_upgrade": {
		"name": "name",
		"type": "upgrade",
		"price": 150000,
		"frame": 16,
		"description": "An even classier experience, increasing money earned per passenger.",
		"effect": "func(): pass",
		"tier": 1
	},
	"caboose_upgrade": {
		"name": "name",
		"type": "upgrade",
		"price": 250000,
		"frame": 17,
		"description": "Better facilities lead to reduced cost per employee. Don't worry, their wages aren't negatively affected.",
		"effect": "func(): pass",
		"tier": 1
	},
	"boxcar_upgrade": {
		"name": "name",
		"type": "upgrade",
		"price": 75000,
		"frame": 18,
		"description": "Doubles the capacity of freight that can be transported.",
		"effect": "func(): pass",
		"tier": 1
	},
}
