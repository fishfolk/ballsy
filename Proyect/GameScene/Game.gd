extends Node2D

class_name Game

var players = []
var ball

var score_board:Vector2 = Vector2(0,0)

func on_add_goal(team):

	if(team < 2):
		score_board.x += 1
	else: score_board.y += 1

var current_player:int


func _changePlayer(id):
	players[current_player].is_controlled = false
	players[current_player].pass_ball(players[id])
	players[id].is_controlled = true
	current_player = id

func _ready():
# warning-ignore:return_value_discarded
	Signals.connect("add_goal",self,"on_add_goal")
	
	current_player = 0
	players = [
		$YSort/Juanito_el_portero ,
		$YSort/Juancho_el_defenza ,
		$YSort/el_paco_el_defenza ,
		$YSort/javier_el_delantero ,
		$YSort/Jorge_el_delantero
	]
	players[current_player].is_controlled = true
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	_check_change_player()
	pass



func _check_change_player():
	var not_change_pressed:bool = not Input.is_action_just_pressed("change_defensive")
	not_change_pressed = not_change_pressed and not Input.is_action_just_pressed("change_offensive")
	if  not_change_pressed :
		return
	var f:int = current_player +  int(Input.get_axis("change_defensive","change_offensive"))
	if f < 0 :
		f = len(players)-1
	f = f % len(players)
	_changePlayer(f)
