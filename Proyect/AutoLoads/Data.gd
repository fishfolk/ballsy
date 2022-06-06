extends Node

var field_dimsx = Vector2(58, 976)
var field_dimsy = Vector2(82, 466)

var PlayerInputs=[
	{
		"up": "player1_up",
		"down":"player1_down",
		"left": "player1_left",
		"right":"player1_right",
		"offensive": "player1_change_offensive",
		"defensive":"player1_change_defensive",
		"strike": "player1_strike",
		"skill": "player1_ultimate"
	},
	{
		"up": "player2_up",
		"down":"player2_down",
		"left": "player2_left",
		"right":"player2_right",
		"offensive": "player2_change_offensive",
		"defensive":"player2_change_defensive",
		"strike": "player2_strike",
		"skill": "player2_ultimate"
	}
]

func get_random_field_coord():
	randomize()
	var size = Vector2(field_dimsx.y - field_dimsx.x, field_dimsy.y - field_dimsy.x)
	var coord = Vector2(field_dimsx.x + randi() % int(size.x),field_dimsy.x + randi() % int(size.y))
	return coord
func get_percent(pos:Vector2):
	var diff = Vector2(field_dimsx.y - field_dimsx.x, field_dimsy.y - field_dimsy.x)
	var fpos = pos - Vector2(field_dimsx.x, field_dimsy.x)
	var ppos:Vector2 = fpos / diff
	return ppos
