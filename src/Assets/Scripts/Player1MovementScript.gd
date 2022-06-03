extends KinematicBody2D


#Floats
var P1timeTillNextInput = 0.2
var P1time = P1timeTillNextInput

#Booleans
var P1canMove = true
var P1wasInputMade = false
var P1isCrouching = false

#Integers
var P1movementSpeed = 100

#Arrays
var P1usedKeys = []

#Vectors

#Objects
onready var P1playerAnimTree = $AnimationTree.get("parameters/playback")

#References
var P1generalMoveSetAnims = MoveSetManager.nameDictionary["General"]
var P1specificMoveSetAnims = MoveSetManager.nameDictionary
	
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			var character = OS.get_scancode_string(event.scancode)
			
			
			if "WASDV".find(character) >= 0:
				P1wasInputMade = true
				P1time = P1timeTillNextInput
				P1usedKeys.append(character)
	
func _process(delta):
	if(P1canMove):
		
		if(Input.is_action_pressed("p1_move_left")):
			_move_player(-1)
		elif(Input.is_action_pressed("p1_move_right")):
			_move_player(1)
		
	
	if(P1wasInputMade):
		P1time -= delta
		
		if(P1time < 0 && P1usedKeys !=null):
			_send_combo_attempt(P1usedKeys)
			P1wasInputMade = false
			P1time = P1timeTillNextInput
			P1usedKeys.clear()
			return
	
	if(Input.is_action_pressed("p1_crouch")):
		P1playerAnimTree.travel(P1generalMoveSetAnims[2])
		P1isCrouching = true
		return
	else:
		P1playerAnimTree.travel(P1generalMoveSetAnims[1])
		P1isCrouching = false
		return
	
func _send_combo_attempt(var attempt = []):
	if(attempt.size() == 1 && !attempt.has("S") && attempt.has("V") || P1isCrouching == true && attempt.has("V")): # wenn er auch wirklich schlägt
		if(P1isCrouching):
			P1playerAnimTree.travel(P1generalMoveSetAnims[4])
		else:
			P1playerAnimTree.travel(P1generalMoveSetAnims[3])
	
	if(attempt.size() > 1):
		if(attempt in P1specificMoveSetAnims[name]):
			P1playerAnimTree.travel(P1specificMoveSetAnims[name][attempt])
	
	print(attempt)
	
func _move_player(var moveDir):
	var velocity = Vector2()
	velocity.x += moveDir * P1movementSpeed
	velocity = move_and_slide(velocity)
	
func _allowed_to_move(var input):
	P1canMove = input
	
	
	
