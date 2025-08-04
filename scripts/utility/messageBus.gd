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
#UPDATES THE TRIP PROGRESS BAR
signal updateProgressBar(index)
#SETS LENGTH OF TRIP FOR THE PROGRESS BAR
signal setTripLength(index)
#SETS TUNNEL POSITION IN TRIP
signal setTunnelPosition(index)
#UPDATES PLAYER LOCATION ON THE MAP
signal updatePlayerLocation()
#BEGINS THE NEWEST TRIP BY PROVIDING TRIP INFORMATION
signal sendItinerary(itinerary)
signal resumeTrip()
signal makeMapVisible()
signal resetProgressBar()

func _ready():
	pass
