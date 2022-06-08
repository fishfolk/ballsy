extends MainCharacter


#AI Func
func _auto_target():
	if !_ia_active: return
	_target_move = Globals.game.ball.position
	return


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
