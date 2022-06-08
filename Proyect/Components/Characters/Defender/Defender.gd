extends MainCharacter


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#AI Func
func _auto_target():
	if !_ia_active: return
	var closed_enemy = Globals.game.get_enemy_closed(self)
	var distance_to_cover = position.distance_to(closed_enemy.position)
	var distance_to_ball = position.distance_to(Globals.game.ball.position)
	var n = [5 * 100/distance_to_ball, 9 * 100/distance_to_cover].find([distance_to_ball,distance_to_cover].max())
	_target_move = [Globals.game.ball.position, closed_enemy.position][n]
	return

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
