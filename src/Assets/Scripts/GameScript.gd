extends Node2D

onready var givenPlayer1 = CharacterSelectionManager.player1.instance()
onready var givenPlayer2 = CharacterSelectionManager.player2.instance()

func _ready():
	SpawnChosenCharacters()
	
func SpawnChosenCharacters():
	givenPlayer1.position.x -= 50
	givenPlayer1.set_script(CharacterSelectionManager.player1Script)
	
	call_deferred("add_child", givenPlayer1)
	
	givenPlayer2.position. x += 50
	givenPlayer2.set_script(CharacterSelectionManager.player2Script)
	
	call_deferred("add_child", givenPlayer2)
