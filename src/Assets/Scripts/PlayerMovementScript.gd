extends KinematicBody2D


#Floats
var timeTillNextInput = 0.2
var time = timeTillNextInput

#Integers
var wasInputMade = false
var isCrouching = false

#Arrays
var usedKeys = []

#Vectors

#Objects
onready var playerAnimTree = $AnimationTree.get("parameters/playback")

#References
var generalMoveSetAnims = MoveSetManager.nameDictionary["General"]
var specificMoveSetAnims = MoveSetManager.nameDictionary
	
	
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and not event.echo:
			var character = OS.get_scancode_string(event.scancode)
			
			
			if "WASDLP".find(character) >= 0:
				wasInputMade = true
				time = timeTillNextInput
				usedKeys.append(character)
	
func _process(delta):
	if(wasInputMade):
		time -= delta
		
		if(time < 0 && usedKeys !=null):
			_send_combo_attempt(usedKeys)
			wasInputMade = false
			time = timeTillNextInput
			usedKeys.clear()
			return
	
	if(Input.is_action_pressed("crouch")):
		playerAnimTree.travel(generalMoveSetAnims[2])
		isCrouching = true
		return
	else:
		playerAnimTree.travel(generalMoveSetAnims[1])
		isCrouching = false
		return
	
func _send_combo_attempt(var attempt = []):
	if(attempt.size() == 1 && !attempt.has("S") && attempt.has("L")): # wenn er auch wirklich schlägt
		if(isCrouching):
			playerAnimTree.travel(generalMoveSetAnims[4])
		else:
			playerAnimTree.travel(generalMoveSetAnims[3])
	
	if(attempt.size() > 1):
		if(attempt in specificMoveSetAnims[name]):
			playerAnimTree.travel(specificMoveSetAnims[name][attempt])
	
	print(attempt)
	
	
	
	
	
