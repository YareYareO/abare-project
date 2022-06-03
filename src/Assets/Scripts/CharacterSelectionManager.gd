extends Node

var player1
var player1Script = preload("res://src/Assets/Scripts/Player1MovementScript.gd")

var player2 
var player2Script = preload("res://src/Assets/Scripts/Player2MovementScript.gd")

var selectableCharacters = {
	"Ryu" : preload("res://src/Scenes/Characters/Ryu/Ryu.tscn"),
	"E Honda" : preload("res://src/Scenes/Characters/E Honda/E Honda.tscn")
}
