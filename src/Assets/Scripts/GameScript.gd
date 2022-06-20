extends Node2D

onready var givenPlayer1 = CharacterSelectionManager.player1.instance()
onready var givenPlayer2 = CharacterSelectionManager.player2.instance()

onready var HUDManager = get_node("HUD Elements")

var spawnpos = {
	"Ryu" : [100, 30],
	"E Honda" : [100, 45]
	
}

func _ready():
	SpawnChosenCharacters()
	
func SpawnChosenCharacters():
	givenPlayer1.position.x -= spawnpos[givenPlayer1.name][0]
	givenPlayer1.position.y += spawnpos[givenPlayer1.name][1]
	givenPlayer1.set_script(CharacterSelectionManager.player1Script)
	
	call_deferred("add_child", givenPlayer1)
	
	givenPlayer2.position. x += spawnpos[givenPlayer2.name][0]
	givenPlayer2.position.y += spawnpos[givenPlayer2.name][1]
	givenPlayer2.set_script(CharacterSelectionManager.player2Script)
	
	call_deferred("add_child", givenPlayer2)
