extends GPUParticles2D

@onready var smoke_amount: float = 0.1
@onready var smoke_drag: float = -15.0

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	smoke()

func smoke():
	self.amount_ratio = get_parent().current_speed * smoke_amount
	self.process_material.gravity.x = get_parent().current_speed * smoke_drag
