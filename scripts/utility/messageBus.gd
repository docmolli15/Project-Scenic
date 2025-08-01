extends Node

#INCREASE SPEED
signal shovelCoal
#ARRIVE AT A STATION
signal stationStop
#DELETES STATION
signal stationDelete
#SUMMONS TUNNEL
signal summonTunnel
#DELETES TUNNEL
signal deleteTunnel
#CHANGES TO DESIRED LANDSCAPE
signal selectLandscape(index)
#UPDATES THE SPEED GAUGE IN THE UI
signal updateSpeedGauge

func _ready():
	pass
