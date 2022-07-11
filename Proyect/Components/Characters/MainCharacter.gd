extends KinematicBody2D
class_name MainCharacter

# func vars
export var active :bool = true


# Player Flags
export var is_controlled:bool = false

# Settigns
var speed: float = 6
export var team:int = 0

#IA vars
var _ia_active:bool = true
export var _player_to_pass:int = 5

#Anim Flags
var _is_walking:bool = false

#Nav Vars
var _original_position:Vector2
var _target_move:Vector2
export var bounds = {
	"x":{ "min": 0, "max":1},
	"y":{"min": 0, "max":0.5}
}

#Nodes
var _played_ndicator:Node2D

func _getbound():
	pass

func reset_position(): _target_move = _original_position


func pass_ball(target:Node2D):
#
#	if _ball == null: return
#	var direction:Vector2 = _ball.position.direction_to(target.position)
#	var distance:float = _ball.position.distance_to(target.position)
#	var force = direction * (distance * 2 + 100)
#	_ball.apply_force_filtered(force,self)
	pass

# Node Stand Func
func _ready():
	_played_ndicator = $Sprite/PlayableIndicator
	Signals.connect("on_goal",self,"on_goal")
	Signals.connect("on_resume",self,"on_resume")
	_played_ndicator.visible = is_controlled
	_original_position = position;
	_target_move = Data.get_random_field_coord()
	$AnimationPlayer.play("Idle")
	speed *= 1000
	if(is_controlled): return


func _physics_process(delta):
	if(!Globals.in_match): return
	if !is_controlled: _auto_target()
	_base_physics(_set_delta(delta))

func _set_delta(delta): return Globals.timescale * delta


func _base_physics(delta):
	if not active: return
	if(is_controlled):
		
		_human_move(delta)
		return
	_is_walking = false
	_machine_move(delta)

func _process(_delta):
	if(!Globals.in_match): return
	_played_ndicator.visible = is_controlled
	if not active: return
	$AnimationPlayer.playback_speed = Globals.timescale
	if _is_walking:
		$AnimationPlayer.play("Walk")
	else: $AnimationPlayer.play("Idle")
	if(is_controlled):
		if Input.is_action_just_pressed(Data.PlayerInputs[team].skill): _activate_hablility()
		_strike()
		return

#AI Func
func _auto_target():
	if !_ia_active: return
	var closed_enemy = Globals.game.get_enemy_closed(self)
	var distance_to_cover = position.distance_to(closed_enemy.position)
	var distance_to_ball = position.distance_to(Globals.game.ball.position)
	var n = [9 * 100/distance_to_ball, 6 * 100/distance_to_cover].find([distance_to_ball,distance_to_cover].max())
	_target_move = [Globals.game.ball.position, closed_enemy.position][n]




func _machine_move(delta):
	var percent:Vector2 = Data.get_percent(_target_move)
	var xsize:Vector2 = Vector2(bounds.x.min,bounds.x.max) 
	var ysize:Vector2 = Vector2(bounds.y.min,bounds.y.max) 
	if(team > 0):
		var dist = xsize.y - xsize.x
		xsize = Vector2(1 - dist - bounds.x.min,1 - bounds.x.min)
	percent.x = clamp(percent.x, xsize.x,xsize.y)
	percent.y = clamp(percent.y, ysize.x,ysize.y)
	_target_move = Data.field_to_world(percent)
	var distance = position.distance_to(_target_move)
	var dir = position.direction_to(_target_move)
	if _player_to_pass < 5:
		pass_ball(Globals.game.teams[team].npcs[_player_to_pass])
	else: pass_ball(Globals.game.teams[team].current_npc)
	if distance < 10 :
		 dir = Vector2.ZERO
	_move_to(delta, dir)
	pass


#Player Func

func _strike():
	if not Input.is_action_just_pressed(Data.PlayerInputs[team].strike): return
	print("(127) MainCharacter: Strike!!")
	var enemy = (team + 1) % 2
	var arc = Globals.game.teams[enemy].goal_arc
	Globals.game.ball.strike(self as Node2D , arc as Node2D)
	pass


func _activate_hablility():
	pass

func _human_move(delta):
	var horizontal_axis:float = Input.get_axis(Data.PlayerInputs[team].left,Data.PlayerInputs[team].right)
	var vertical_axis:float = Input.get_axis(Data.PlayerInputs[team].down, Data.PlayerInputs[team].up)
	_move_to(delta, Vector2(horizontal_axis,-vertical_axis) * 1.4)

#Nav

func on_goal():
	is_controlled = false
	_ia_active = false
	reset_position()

func on_resume():
	_ia_active = true

# Movement
func _move_to(delta, dir):
	_is_walking = not (dir.x == 0 and dir.y == 0)
	
	if not _is_walking: return
	$Sprite.flip_h = not dir.x >= 0

	var horizontal_velocity:Vector2 = speed * Vector2(1,0) * dir.x * delta
	var vertical_velocity:Vector2 = speed * Vector2(0,1) * dir.y * delta
# warning-ignore:return_value_discarded
	move_and_slide(horizontal_velocity + (vertical_velocity), Vector2.UP)

