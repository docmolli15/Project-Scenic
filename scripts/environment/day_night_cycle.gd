extends CanvasModulate

@export var gradient: GradientTexture1D
@export var cycle_speed: float = 1.0

var time: float = 1.0

func _process(delta: float) -> void:
	time += delta * cycle_speed
	var value = (sin(time - PI / 2) + 1.0) / 2
	self.color = gradient.gradient.sample(value)
