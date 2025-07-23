extends ParallaxBackground

@onready var entrance = %entrance


func _ready() -> void:
	pass
	
#FUNCTION TO START THE MOVEMENT OF THE TUNNEL TOWARD THE TRAIN
func enterTunnel(frame): #TAKES IN PARAMETER THAT DECIDES BETWEEN ENTRANCE/EXIT
	#SWITCH THE SPRITE TO 'frame'
	#MATCH SPEED OF THE TUNNEL SPRITE WITH THE TRACKS
	entrance.motion_scale = Vector2(0.7, 0.7)
	#CREATE A TRIGGER THAT FIRES A SIGNAL WHEN THE SPRITE CROSSES THRESHOLD, RESETTING FOR NEXT TIME
	
func _on_enter_pressed() -> void:
	enterTunnel(0)

func _on_exit_pressed() -> void:
	enterTunnel(1)
