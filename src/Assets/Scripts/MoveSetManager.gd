extends Node

var generalMoves = {
	1 : "Idle",
	2 : "Crouch Idle",
	3 : "Jab",
	4 : "Crouch Jab",
	5 : "Shoryuken"
}


var ryuMoves = {
	["L", "P", "P"] : "Shoryuken",
	["S", "D", "S", "D", "L"] : "Shoryuken"
}




var nameDictionary = {
	"General" : generalMoves,
	"Ryu" : ryuMoves
}
