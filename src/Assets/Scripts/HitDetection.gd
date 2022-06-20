extends Area2D

onready var gameRef = get_parent().get_parent()
onready var characterRef = get_parent()


func _on_Area2D_body_entered(body):
	print(body.name)
	characterRef._hurt_other_player()
