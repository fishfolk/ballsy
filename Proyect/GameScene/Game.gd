extends Node2D

var players = []
var ball

var current_player:int


func _changePlayer(id):
	players[current_player].is_controlled = false
	players[current_player].pass_ball(players[id])
	players[id].is_controlled = true
	current_player = id

func _ready():
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

func _process(delta):
	_check_change_player()
	pass



func _check_change_player():
	var not_change_pressed:bool = not Input.is_action_just_pressed("change_defensive")
	not_change_pressed = not_change_pressed and not Input.is_action_just_pressed("change_offensive")
	if  not_change_pressed :
		return
	var f:int = current_player +  Input.get_axis("change_defensive","change_offensive")
	if f < 0 :
		f = len(players)-1
	f = f % len(players)
	_changePlayer(f)
