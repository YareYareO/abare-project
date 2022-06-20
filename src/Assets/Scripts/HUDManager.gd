extends Control

onready var player1HealthBar = get_node("KO-bar Holder/Player1Health")
onready var player2HealthBar = get_node("KO-bar Holder/Player2Health")

func _reduce_health_from(var whichPlayer, var damage): # whichPlayer boolean true heißt player 1, false heißt player2 
	print(player1HealthBar.value)
	if(whichPlayer):
		player1HealthBar.value -= damage
	else:
		player2HealthBar.value -= damage
		
