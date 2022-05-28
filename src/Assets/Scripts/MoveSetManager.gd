extends Node

var generalMoves = {
	1 : "Idle",
	2 : "Crouch Idle",
	3 : "Jab",
	4 : "Crouch Jab",
	5 : "Shoryuken"
}

# jede Kombination kann jetzt eine andere Animation ausfüren. standing punch, forward punch etc. wie bei tekken
# von jedem Charakter werden zwei versionen erstellt. Player 1 und player 2 (andere farben). 
# diese verbinden sich dann mit den jeweiligen playermovementscript

var ryuMoves = {
	["D", "V"] : "Jab",
	["A", "V"] : "Jab",
	["S", "V"] : "Crouch Jab",
	["S", "D", "S", "D", "V"] : "Shoryuken"
}

var ehondaMoves = {
	["L", "P"] : "Jab",
	["J", "P"] : "Jab",
	["K", "P"] : "Crouch Jab",
	["P", "P", "P"] : "Hundred Hand Slap"
	
}

var nameDictionary = {
	"General" : generalMoves,
	"Ryu" : ryuMoves,
	"E Honda" : ehondaMoves
}
