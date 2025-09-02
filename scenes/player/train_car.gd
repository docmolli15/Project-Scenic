extends Node2D

class_name TrainCar

@export_enum("coal", "box", "luxury", "caboose", "passenger")

var car_type: String
var seats: int
var passengers = []
var cubbies: int
var freight = []
var jobs: int
var employees = []
var multiplier: float
var upsells: int
var stoker: bool

const CAR_STATS = {
	"coal": {
		"seats": 0, "cubbies": 0, "jobs": 1, "money multiplier": 0.0, "upsells": 0, "unlock": true
	}, "box": {
		"seats": 0, "cubbies": 4, "jobs": 3, "money multiplier": 0.0, "upsells": 0, "unlock": 0
	}, "luxury": {
		"seats": 0, "cubbies": 0, "jobs": 3, "money multiplier": 0.5, "upsells": 4, "unlock": 0
	}, "caboose": {
		"seats": 0, "cubbies": 0, "jobs": 0, "money multiplier": 0.0, "upsells": 0, "unlock": true
	}, "passenger": {
		"seats": 4, "cubbies": 0, "jobs": 0, "money multiplier": 0.0, "upsells": 0, "unlock": 0
	}
}

func _ready():
	pass

func create_car():
	pass
