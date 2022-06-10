extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.in_match = false


func _on_Exit_button_down():
	get_tree().quit()
	pass # Replace with function body.


func _on_Versus_button_down():
	Signals.emit_signal("start_versus");
	Globals.in_match = false
	pass # Replace with function body.
