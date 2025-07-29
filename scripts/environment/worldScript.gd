extends Node2D

var tunnel = preload("res://scenes/tunnel.tscn")
@onready var tunnelTimer = %Timer

func _ready() -> void:
	#CONNECTION TO THE MESSAGE BUS FOR STARTING THE TUNNEL TRANSITION
	MessageBus.tunnelTransition.connect(unlockTunnel)
	
func _process(_delta: float) -> void:
	#KEEP TUNNEL AHEAD OF TRAIN, READY FOR TRANSITION
	holdTunnel()

func unlockTunnel():
	#VARIABLE FOR THE TUNNEL SCENE
	var new_tunnel = tunnel.instantiate()
	#CHECK STATUS OF TUNNEL LOCKING VARIABLE IN THE GLOBAL SCRIPT
	if Global.tunnelLock == false:
		print("success")
		#IF UNLOCKED, BEGIN THE PROCESS BY LOCKING THE VARIABLE 
		Global.tunnelLock = true
		print(Global.tunnelLock)
		#LOCK THE LOCOMOTION VARIABLE AND SET LOCOMOTION TO 3
		Global.locomotionLock = true
		Global.locomotion = 3
		#SPAWN THE TUNNEL
		add_child(new_tunnel)
		#START TRANSITION TIMER
		tunnelTimer.start()
	else:
		print("tunnel not ready")

func holdTunnel():
	#IF VARIABLE IS FALSE, KEEP THE TUNNEL AHEAD OF THE PLAYER OUTSIDE OF CAMERA BOUNDS
	if Global.tunnelLock == false:
		pass
		#tunnel.position.x += 1500

func _on_timer_timeout() -> void:
	#UNLOCK THE TUNNEL LOCKING VARIABLE
	Global.tunnelLock = false
	#SIGNAL THE TUNNEL TO DELETE ITSELF
	MessageBus.deleteTunnel.emit()
