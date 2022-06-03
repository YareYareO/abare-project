extends KinematicBody2D


#Floats
var P1timeTillNextInput = 0.18
var P1time = P1timeTillNextInput

#Booleans
var P1canMove = true
var P1wasInputMade = false
var P1isCrouching = false

#Integers
var P1movementSpeed = 100

var P1moveDir = 1

#Arrays
var P1usedMovement = []
var P1usedAttack = []

#Vectors

#Objects
onready var P1playerAnimTree = $AnimationTree.get("parameters/playback")
onready var P1gameRef = get_parent()
onready var player2 = get_parent().get_node(P1gameRef.givenPlayer2.name)

#References
var P1generalMoveSetAnims = MoveSetManager.nameDictionary["General"]
var P1specificMoveSetAnims = MoveSetManager.nameDictionary
	
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			var character = OS.get_scancode_string(event.scancode)
			
			if "WASD".find(character) >= 0:
				P1wasInputMade = true
				P1time = P1timeTillNextInput
				P1usedMovement.append(_appendrightchar(character))
			elif "V".find(character) >= 0:
				P1wasInputMade = true
				P1time = P1timeTillNextInput
				P1usedAttack.append(_appendrightchar(character))
				
func _appendrightchar(character):
	if(P1moveDir == 1 || P1moveDir == 0):
		if(character == "D"):
			return "forward"
		if(character == "A"):
			return "backward"
	if(P1moveDir == -1):
		if(character == "D"):
			return "backward"
		if(character == "A"):
			return "forward"
	if(character == "V"):
		return "punch"
	if(character == "S"):
		return "down"
	if(character == "W"):
		return "up"
		
	
func _process(delta):
	
	if(P1canMove):
		#_face_player()
		if(Input.is_action_pressed("p1_move_left")): #
			_move_player(-1)
		elif(Input.is_action_pressed("p1_move_right")):
			_move_player(1)
		
	
	
	if(P1wasInputMade):
		P1time -= delta
		if(P1time < 0 || P1usedMovement.size() == 4 || P1usedAttack.size() == 4):
			_send_combo_attempt(P1usedMovement.slice(P1usedMovement.size()-3, P1usedMovement.size()-1), P1usedAttack.slice(P1usedAttack.size()-3, P1usedAttack.size()-1)) 
																# nimm die letzten drei werte der arrays
			P1wasInputMade = false
			P1time = P1timeTillNextInput
			P1usedMovement.clear()
			P1usedAttack.clear()
			return
	
	if(Input.is_action_pressed("p1_crouch")):
		P1playerAnimTree.travel(P1generalMoveSetAnims[2])
		P1isCrouching = true
		return
	else:
		P1playerAnimTree.travel(P1generalMoveSetAnims[1])
		P1isCrouching = false
		return
	
func _send_combo_attempt(var moveattempt = [], var attackattempt = []):
	var fullattempt = moveattempt + attackattempt
	if(fullattempt in P1specificMoveSetAnims[name]):
		P1playerAnimTree.travel(P1specificMoveSetAnims[name][fullattempt])
		
	elif(attackattempt in P1specificMoveSetAnims[name] && moveattempt.size() <= 1):
		P1playerAnimTree.travel(P1specificMoveSetAnims[name][attackattempt])
	
	elif(moveattempt in P1specificMoveSetAnims[name]):
		P1playerAnimTree.travel(P1specificMoveSetAnims[name][moveattempt])
			
	elif(attackattempt in P1generalMoveSetAnims && P1isCrouching):
		var temp = ["down", attackattempt[0]]
		P1playerAnimTree.travel(P1generalMoveSetAnims[temp])
		
	elif(attackattempt in P1generalMoveSetAnims):
		P1playerAnimTree.travel(P1generalMoveSetAnims[attackattempt[0]])
		
	print(moveattempt)
	print(attackattempt)
	print(fullattempt)
	
	
func _move_player(var moveDir):
	
	var velocity = Vector2()
	velocity.x += moveDir * P1movementSpeed
	velocity = move_and_slide(velocity)
	
func _allowed_to_move(var input):
	P1canMove = input
	
"""func _face_player():
	print(player2)
	var distanceToPlayer2 = player2.position.x - position.x
	
	if(distanceToPlayer2 > 0):
		P1moveDir = 1
		scale.x = scale.y * P1moveDir
	elif(distanceToPlayer2 < 0):
		P1moveDir = -1
		scale.x = scale.y * P1moveDir 
	else:
		P1moveDir = 0		
"""
	
	
	
