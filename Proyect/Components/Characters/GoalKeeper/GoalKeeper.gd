extends MainCharacter


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _activate_hablility():
	._activate_hablility()
	Globals.timescale = 0.5;
	yield(get_tree().create_timer(5),"timeout")
	Globals.timescale = 1;

func _set_delta(delta):
	return delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
