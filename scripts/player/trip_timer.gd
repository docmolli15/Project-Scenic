extends Node

var duration: float = 0.0
var elapsed_time: float = 0.0
var running: bool = false
var time_modifier: float = 1.0

var tunnel_trigger_points: Array = []
var tunnel_trigger_frames: Array = []
var triggered_indices: Array = []

func start_timer(new_duration: float, triggers: Array, frames: Array) -> void:
	duration = new_duration
	elapsed_time = 0.0
	running = true
	tunnel_trigger_points = triggers.duplicate()
	tunnel_trigger_frames = frames.duplicate()
	triggered_indices.clear()

func stop_timer() -> void:
	running = false

func _process(delta: float) -> void:
	if not running:
		return

	elapsed_time += delta * (Global.current_speed / time_modifier)

	Global.trip_progress = clamp(elapsed_time / duration, 0.0, 1.0)

	for i in range(tunnel_trigger_points.size()):
		if i in triggered_indices:
			continue
		if elapsed_time >= tunnel_trigger_points[i] * duration:
			triggered_indices.append(i)
			_on_tunnel_trigger(i)

	if Global.trip_progress >= 1.0:
		running = false
		_on_timer_timeout()

func _on_tunnel_trigger(index: int) -> void:
	MessageBus.tunnelled_through.emit(tunnel_trigger_frames[index])

func _on_timer_timeout() -> void:
	MessageBus.trip_timer_ends.emit()
	print('trip over')
