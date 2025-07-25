extends ParallaxBackground

@onready var entrance = %entrance


func _ready() -> void:
	enterTunnel()
	
#FUNCTION TO START THE MOVEMENT OF THE TUNNEL TOWARD THE TRAIN
func enterTunnel():
	#MATCH SPEED OF THE TUNNEL SPRITE WITH THE TRACKS
	entrance.motion_scale = Vector2(0.7, 0.7)

#FUNCTION TO DELETE THE TUNNEL SCENE ONCE ITS BEEN USED
func _on_reset_trigger_delete_tunnel() -> void:
	queue_free()
