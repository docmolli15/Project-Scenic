extends Node

var purchased_items: Dictionary = {
	"caboose": false,
	"coffee_bar": false,
	"dining_service": false,
	"engine_upgrade_1": false,
	"engine_upgrade_2": false,
	"engine_upgrade_3": false,
	"engine_upgrade_4": false,
	"delicate_item_storage": false,
	"employee_capacity": false,
	"passenger_car_upgrade": false,
	"coal_car_upgrade": false,
	"luxury_car_upgrade": false,
	"caboose_upgrade": false,
	"boxcar_upgrade": false
}

var current_station = ""
var dynamic_player_stats: Dictionary = {
	"max cars": 6, "seats": 1, "cubbies": 2, "jobs": 0, "upsells": 0, 
	"money mult": 0.0, "friction reducer": -0.00, "delicate cubbies": 0,
	"stokers_employed": 0
}
var car_data = []
var passenger_data = []
var package_data = []
