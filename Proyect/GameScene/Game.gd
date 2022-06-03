extends Node2D

class_name Game

var players = []
var ball
var teams = []
var score:Vector2 = Vector2(0,0)

func get_score(): return score

func on_add_goal(team):
	if(team < 1):
		score.x += 1
	else: score.y += 1
	Globals.score_board.display_score(score)
	Globals.goalAnim.play()
	teams[0].current_npc.is_controlled = false
	teams[1].current_npc.is_controlled = false
	for npc in teams[0].npcs:
		npc.reset_position()
	for npc in teams[1].npcs:
		npc.reset_position()
	yield(get_tree().create_timer(5),"timeout")
	teams[0].current_npc.is_controlled = true
	teams[1].current_npc.is_controlled = true
	ball.reset_pos()


func get_current_character(team:int = 0): return teams[team].current_npc

func _changePlayer(id:int, team:int = 0):
	var old_playable = teams[team].current_npc
	var new_playable = teams[team].npcs[id]
	old_playable.is_controlled = false
	old_playable.pass_ball(new_playable)
	new_playable.is_controlled = true
	teams[team].current_npc = new_playable
	teams[team].current_id = id

func _ready():
	Globals.game = self
	ball = $YSort/Ball
# warning-ignore:return_value_discarded
	Signals.connect("add_goal",self,"on_add_goal")
	_set_teams();
	teams[0].current_npc.is_controlled = true
	teams[1].current_npc.is_controlled = true
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	_check_change_player(0)
	_check_change_player(1)
	pass



func _check_change_player(team:int = 0):
	var not_change_pressed:bool = not Input.is_action_just_pressed(Data.PlayerInputs[team].offensive)
	not_change_pressed = not_change_pressed and not Input.is_action_just_pressed(Data.PlayerInputs[team].defensive)
	if  not_change_pressed :
		return
	var f:int = teams[team].current_id +  int(Input.get_axis(Data.PlayerInputs[team].defensive,Data.PlayerInputs[team].offensive))
	f = clamp(f, 0,4)
	print(f)
	_changePlayer(f,team)

func _set_teams():
	teams = [
		{
			"npcs":[
				$YSort/team1_gp,
				$YSort/team1_du,
				$YSort/team1_dd,
				$YSort/team1_su,
				$YSort/team1_sd
			],
			"current_npc":$YSort/team1_sd,
			"current_id":4,
			"goal_arc": $YSort/team1_arc
		},
		{
			"npcs":[
				$YSort/team2_gp,
				$YSort/team2_du,
				$YSort/team2_dd,
				$YSort/team2_su,
				$YSort/team2_sd
			],
			"current_npc":$YSort/team2_su,
			"current_id":3,
			"goal_arc": $YSort/team2_arc
		}
	]
