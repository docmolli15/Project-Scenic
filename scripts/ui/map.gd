extends Node2D

#VARIABLE CONTROLLING WHEN MAP BUTTONS ARE INTERACTABLE
@export var mapInteract: bool
#BUTTONS FOR CHOOSING DESTINATION
@onready var buttonA = %A
@onready var buttonB = %B
@onready var buttonC = %C
@onready var buttonD = %D
@onready var buttonE = %E
#ROUTE VARIABLES
@onready var red1 = %Red1
@onready var red2 = %Red2
@onready var red3 = %Red3
@onready var green1 = %Green1
@onready var green2 = %Green2
@onready var green3 = %Green3
@onready var purple1 = %Purple1
#ARRAYS THAT CONTAIN INFORMATION NEEDED FOR EACH DIRECTION OF EACH ROUTE
var AtoC = [red2, 3, 0.15, 2]
var AtoE = [green2, 1, 0.60, 0 ]
var AtoB = [red1 ,3, 0.50, 1 ]
var AtoD = [green1, 0.50, 0.1, 3]
var BtoA = [red1 ,3, 0.50, 1]
var BtoC = [red3, 3, 0.50, 2]
var CtoA = [red2, 3, 0.85, 1]
var CtoB = [red3, 3, 0.50, 1]
var CtoE = [purple1, 3, 0.60, 0]
var EtoC = [purple1, 8, 0.40, 2]
var EtoA = [green2, 1, 0.40, 1]
var EtoD = [green3, 1, 0.90, 3]
var DtoE = [green3, 1, 0.90, 0]
var DtoA = [green1, 0.5, 0.90, 3]
#PLAYERS CURRENT LOCATION, DICTATING WHAT CHOICES THEY HAVE
var player_location = 4

func _ready():
	MessageBus.updatePlayerLocation.connect(currentLocation)
	MessageBus.makeMapVisible.connect(mapVisible)
	unlockCities()

func mapVisible():
	self.visible = true

#SETS PLAYER CITY AT ARRIVAL
func currentLocation():
	if player_location == 0:
		Global.player_location = 0
	elif player_location == 1:
		Global.player_location = 1
	elif player_location == 2:
		Global.player_location = 2
	elif player_location == 3:
		Global.player_location = 3
	elif player_location == 4:
		Global.player_location = 4
	unlockCities()

#UNLOCK SELECTABLE CITIES
func unlockCities():
	if player_location == 0:
		buttonA.disabled = true
		buttonB.disabled = false
		buttonC.disabled = false
		buttonD.disabled = false
		buttonE.disabled = false
	elif player_location == 1:
		buttonA.disabled = false
		buttonB.disabled = true
		buttonC.disabled = false
		buttonD.disabled = true
		buttonE.disabled = true
	elif player_location == 2:
		buttonA.disabled = false
		buttonB.disabled = false
		buttonC.disabled = true
		buttonD.disabled = true
		buttonE.disabled = false
	elif player_location == 3:
		buttonA.disabled = false
		buttonB.disabled = true
		buttonC.disabled = true
		buttonD.disabled = true
		buttonE.disabled = false
	elif player_location == 4:
		buttonA.disabled = false
		buttonB.disabled = true
		buttonC.disabled = false
		buttonD.disabled = false
		buttonE.disabled = true

#ORDERS EXECUTED WHEN A NEW DESTINATION IS SELECTED
func _on_a_pressed():
	if player_location == 1:
		MessageBus.sendItinerary.emit(BtoA)
		self.visible = false
		Global.enroute = true
	if player_location == 2:
		MessageBus.sendItinerary.emit(CtoA)
		self.visible = false
		Global.enroute = true
	if player_location == 4:
		MessageBus.sendItinerary.emit(EtoA)
		self.visible = false
		Global.enroute = true
	if player_location == 3:
		MessageBus.sendItinerary.emit(DtoA)
		self.visible = false
		Global.enroute = true
	player_location = 0
	await get_tree().create_timer(1).timeout
	resetProgressBar()
func _on_b_pressed():
	if player_location == 0:
		MessageBus.sendItinerary.emit(AtoB)
		self.visible = false
		Global.player_location = 0
		Global.enroute = true
	if player_location == 2:
		MessageBus.sendItinerary.emit(CtoB)
		self.visible = false
		Global.player_location = 2
		Global.enroute = true
	player_location = 1
	await get_tree().create_timer(1).timeout
	resetProgressBar()
func _on_c_pressed():
	if player_location == 0:
		MessageBus.sendItinerary.emit(AtoC)
		self.visible = false
		Global.player_location = 0
		Global.enroute = true
	if player_location == 1:
		MessageBus.sendItinerary.emit(BtoC)
		self.visible = false
		Global.player_location = 1
		Global.enroute = true
	if player_location == 4:
		MessageBus.sendItinerary.emit(EtoC)
		self.visible = false
		Global.player_location = 4
		Global.enroute = true
	player_location = 2
	await get_tree().create_timer(1).timeout
	resetProgressBar()
func _on_d_pressed():
	if player_location == 0:
		MessageBus.sendItinerary.emit(AtoD)
		self.visible = false
		Global.player_location = 0
		Global.enroute = true
	if player_location == 4:
		MessageBus.sendItinerary.emit(EtoD)
		self.visible = false
		Global.player_location = 4
		Global.enroute = true
	player_location = 3
	await get_tree().create_timer(1).timeout
	resetProgressBar()
func _on_e_pressed():
	if player_location == 0:
		MessageBus.sendItinerary.emit(AtoE)
		self.visible = false
		Global.player_location = 0
		Global.enroute = true
	if player_location == 2:
		MessageBus.sendItinerary.emit(CtoE)
		self.visible = false
		Global.player_location = 2
		Global.enroute = true
	if player_location == 3:
		MessageBus.sendItinerary.emit(DtoE)
		self.visible = false
		Global.player_location = 3
		Global.enroute = true
	player_location = 4
	await get_tree().create_timer(1).timeout
	resetProgressBar()

func resetProgressBar():
	MessageBus.resetProgressBar.emit()
	
