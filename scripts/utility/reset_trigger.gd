extends Area2D

signal deleteTunnel

#TRIGGER THAT WILL INITIATE THE DELETION OF THE TUNNEL WHEN THE AREA GETS TRIGGERED
func _on_enter_area_area_entered(area: Area2D) -> void:
	deleteTunnel.emit()
