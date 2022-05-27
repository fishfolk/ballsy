extends Node2D

class_name Goal

export var teamowner:int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Area2D_body_entered(body):
	if body.name != "Ball": return
#	emit_signal("add_goal", teamowner)
	
