extends KinematicBody2D


#Floats
var P2timeTillNextInput = 0.18
var P2time = P2timeTillNextInput

#Booleans
var P2canMove = true
var P2wasInputMade = false
var P2isCrouching = false

#Integers
var P2movementSpeed = 100

var P2moveDir 

#Arrays
var P2usedMovement = []
var P2usedAttack = []

#Vectors

#Objects
onready var P2playerAnimTree = $AnimationTree.get("parameters/playback")
onready var P2gameRef = get_parent()
onready var player1 =  get_parent().get_node(P2gameRef.givenPlayer1.name)

#References
var P2generalMoveSetAnims = MoveSetManager.nameDictionary["General"]
var P2specificMoveSetAnims = MoveSetManager.nameDictionary
	
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			var character = OS.get_scancode_string(event.scancode)
			
			if "JKIL".find(character) >= 0:
				P2wasInputMade = true
				P2time = P2timeTillNextInput
				P2usedMovement.append(_appendrightchar(character))
			elif "P".find(character) >= 0:
				P2wasInputMade = true
				P2time = P2timeTillNextInput
				P2usedAttack.append(_appendrightchar(character))
				
func _appendrightchar(character):
	if(P2moveDir == 1 || P2moveDir == 0):
		if(character == "L"):
			return "forward"
		if(character == "J"):
			return "backward"
	if(P2moveDir == -1):
		if(character == "L"):
			return "backward"
		if(character == "J"):
			return "forward"
	if(character == "P"):
		return "punch"
	if(character == "K"):
		return "down"
	if(character == "I"):
		return "up"
		
	
func _process(delta):
	
	if(P2canMove):
		_face_player()
		if(Input.is_action_pressed("p2_move_left")): #
			_move_player(-1)
		elif(Input.is_action_pressed("p2_move_right")):
			_move_player(1)
		
	
	
	if(P2wasInputMade):
		P2time -= delta
		if(P2time < 0 || P2usedMovement.size() == 4 || P2usedAttack.size() == 4):
			print(P2usedAttack)
			print("hfdwuiaqhfaiu")
			_send_combo_attempt(P2usedMovement.slice(P2usedMovement.size()-3, P2usedMovement.size()-1), P2usedAttack.slice(P2usedAttack.size()-3, P2usedAttack.size()-1)) 
			
			P2wasInputMade = false
			P2time = P2timeTillNextInput
			P2usedMovement.clear()
			P2usedAttack.clear()
			return
	
	if(Input.is_action_pressed("p2_crouch")):
		P2playerAnimTree.travel(P2generalMoveSetAnims[2])
		P2isCrouching = true
		return
	else:
		P2playerAnimTree.travel(P2generalMoveSetAnims[1])
		P2isCrouching = false
		return
	
func _send_combo_attempt(var moveattempt = [], var attackattempt = []):
	var fullattempt = moveattempt + attackattempt
	if(fullattempt in P2specificMoveSetAnims[name]):
		P2playerAnimTree.travel(P2specificMoveSetAnims[name][fullattempt])
		
	elif(attackattempt in P2specificMoveSetAnims[name] && moveattempt.size() <= 1):
		P2playerAnimTree.travel(P2specificMoveSetAnims[name][attackattempt])
	
	elif(moveattempt in P2specificMoveSetAnims[name]):
		P2playerAnimTree.travel(P2specificMoveSetAnims[name][moveattempt])
			
	elif(attackattempt in P2generalMoveSetAnims && P2isCrouching):
		var temp = ["down", attackattempt[0]]
		P2playerAnimTree.travel(P2generalMoveSetAnims[temp])
		
	elif(attackattempt in P2generalMoveSetAnims):
		P2playerAnimTree.travel(P2generalMoveSetAnims[attackattempt[0]])
		
	print(moveattempt)
	print(attackattempt)
	print(fullattempt)
	
	
func _move_player(var moveDir):
	
	var velocity = Vector2()
	velocity.x += moveDir * P2movementSpeed
	velocity = move_and_slide(velocity)
	
func _allowed_to_move(var input):
	P2canMove = input
	
func _face_player():
	var distanceToPlayer1 = player1.position.x - position.x
	
	if(distanceToPlayer1 > 0):
		P2moveDir = 1
		scale.x = scale.y * P2moveDir
	elif(distanceToPlayer1 < 0):
		P2moveDir = -1
		scale.x = scale.y * P2moveDir 
	else:
		P2moveDir = 0		
	
	
	
