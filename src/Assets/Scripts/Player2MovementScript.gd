extends KinematicBody2D


#Floats
var P2timeTillNextInput = 0.2
var P2time = P2timeTillNextInput

#Booleans
var P2canMove = true
var P2wasInputMade = false
var P2isCrouching = false

#Integers
var P2movementSpeed = 100
export (int) var offsetTillFlip = 20 # wwwwwwwwwwwwwwwwwwwwwwwwwwww

var moveDir # dfafaqwfawfawfwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

#Arrays
var P2usedKeys = []

#Vectors

#Objects
onready var P2playerAnimTree = $AnimationTree.get("parameters/playback")
onready var gameRef = get_parent()
onready var player1 =  get_parent().get_node(gameRef.givenPlayer1.name)#wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww

#References
var P2generalMoveSetAnims = MoveSetManager.nameDictionary["General"]
var P2specificMoveSetAnims = MoveSetManager.nameDictionary
	
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			var character = OS.get_scancode_string(event.scancode)
			
			if "JKILP".find(character) >= 0:
				P2wasInputMade = true
				P2time = P2timeTillNextInput
				P2usedKeys.append(character)
	
func _process(delta):
	
	if(P2canMove):
		_face_player()
		if(Input.is_action_pressed("p2_move_left")): #
			_move_player(-1)
		elif(Input.is_action_pressed("p2_move_right")):
			_move_player(1)
		
	
	
	if(P2wasInputMade):
		P2time -= delta
		if(P2time < 0 && P2usedKeys !=null):
			_send_combo_attempt(P2usedKeys)
			P2wasInputMade = false
			P2time = P2timeTillNextInput
			P2usedKeys.clear()
			return
	
	if(Input.is_action_pressed("p2_crouch")):
		P2playerAnimTree.travel(P2generalMoveSetAnims[2])
		P2isCrouching = true
		
		return
	else:
		P2playerAnimTree.travel(P2generalMoveSetAnims[1])
		P2isCrouching = false
		return
	
func _send_combo_attempt(var attempt = []):
	if(attempt.size() == 1 && !attempt.has("K") && attempt.has("P") || P2isCrouching == true && attempt.has("P")): # wenn er auch wirklich schlägt
		if(P2isCrouching):
			P2playerAnimTree.travel(P2generalMoveSetAnims[4])
		else:
			P2playerAnimTree.travel(P2generalMoveSetAnims[3])
	
	if(attempt.size() > 1):
		if(attempt in P2specificMoveSetAnims[name]):
			P2playerAnimTree.travel(P2specificMoveSetAnims[name][attempt])
	
	#print(attempt)
	
func _move_player(var moveDir):
	var velocity = Vector2()
	velocity.x += moveDir * P2movementSpeed
	velocity = move_and_slide(velocity)
	
func _allowed_to_move(var input):
	P2canMove = input
	
func _face_player():
	var distanceToPlayer1 = player1.position.x - position.x
	
	if(distanceToPlayer1 > offsetTillFlip):
		moveDir = 1
		scale.x = scale.y * moveDir
	elif(distanceToPlayer1 < -offsetTillFlip):
		moveDir = -1
		scale.x = scale.y * moveDir 
	else:
		moveDir = 0		
	
	
	
