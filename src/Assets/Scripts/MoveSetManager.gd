extends Node

var generalMoves = {
	1 : "Idle",
	2 : "Crouch Idle",
	["punch"] : "Jab",
	"punch" : "Jab",
	["down", "punch"] : "Crouch Jab"
}


# jede Kombination kann jetzt eine andere Animation ausfüren. standing punch, forward punch etc. wie bei tekken
# von jedem Charakter werden zwei versionen erstellt. Player 1 und player 2 (andere farben). 
# diese verbinden sich dann mit den jeweiligen playermovementscript

var ryuMoves = {
	["forward", "forward"] : "Dash",
	["forward", "down", "forward"] : "Dash",
	["forward", "down", "forward", "punch"] : "Shoryuken"
}

var ehondaMoves = {
	["forward", "forward"] : "Dash",
	["forward", "down", "forward"] : "Dash",
	["punch", "punch", "punch"] : "Hundred Hand Slap"
	
}

var nameDictionary = {
	"General" : generalMoves,
	"Ryu" : ryuMoves,
	"E Honda" : ehondaMoves
}
