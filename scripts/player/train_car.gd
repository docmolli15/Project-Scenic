extends Node2D

class_name TrainCar

@onready var train_anim = %AnimatedSprite2D

@export_enum("coal", "box", "luxury", "caboose", "passenger")

var car_type: String
var seats: int
var passengers := []
var cubbies: int
var freight := []
var jobs: int
var employees := []
var multiplier: float
var upsells: int
var stoker: bool
var array_position: int

const SEATS = "seats"
const CUBBIES = "cubbies"
const JOBS = "jobs"
const MULTIPLIER = "money multiplier"
const UPSELLS = "upsells"
const UNLOCK = "unlock"

const CAR_STATS = {
	"coal": {
		SEATS: 0, CUBBIES: 0, JOBS: 1, MULTIPLIER: 0.0, UPSELLS: 0, UNLOCK: true
	},
	"box": {
		SEATS: 0, CUBBIES: 4, JOBS: 3, MULTIPLIER: 0.0, UPSELLS: 0, UNLOCK: 0
	},
	"luxury": {
		SEATS: 0, CUBBIES: 0, JOBS: 3, MULTIPLIER: 0.5, UPSELLS: 4, UNLOCK: 0
	},
	"caboose": {
		SEATS: 0, CUBBIES: 0, JOBS: 0, MULTIPLIER: 0.0, UPSELLS: 0, UNLOCK: true
	},
	"passenger": {
		SEATS: 4, CUBBIES: 0, JOBS: 0, MULTIPLIER: 0.0, UPSELLS: 0, UNLOCK: 0
	}
}

func _ready() -> void:
	await get_tree().process_frame
	set_train_animation()
	var engine = get_tree().get_first_node_in_group("Engine")
	if engine:
		engine.animation_frame_synced.connect(_on_sync_frame)

func _on_sync_frame(frame: int) -> void:
	train_anim.frame = frame

func set_train_animation():
	var available_animations = train_anim.sprite_frames.get_animation_names()
	if car_type in available_animations:
		train_anim.animation = car_type
		train_anim.play()
	else:
		push_warning("No animation found")
		print(car_type)
