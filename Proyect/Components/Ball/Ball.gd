extends RigidBody2D
class_name Ball

##RESET VARS
var _start_position:Vector2 = Vector2(0,0)
var _is_reset:bool = false

##BALL NODES VARS
var _player_owner:MainCharacter = null
var _target:Node2D = null

## Physics Settings
const _DAMP = 6
const _BOUNCE_FORCE = 600

## NOTINTERACTIONS
var _is_interactuable:bool = true
var _time_to_interactuable:float = 0
var _default_time_not_interactuable:float = 3

## TOUCH BODY VARS
const _MAX_DISTANCE_TO_BODY:float = 600.0
var _body_touch:Node2D = null

## PREFCONFIGS
func _ready():
	_start_position = transform.origin
	linear_damp = _DAMP
	pass


func set_target(target:Node2D):
	_target = target

func _physics_process(delta):
	if (_target == null): return
	var direction:Vector2 = _target.position.direction_to(position)
	linear_velocity = direction * (_BOUNCE_FORCE * 0.5)
	pass


## TOUCH RIGGIDBODY
func _on_Ball_body_entered(body):
	print("TOUCH")
	if body is MainCharacter:
		var node:MainCharacter = body
		_strike(node)
	pass # Replace with function body.


## ENTER ON DETECTOR AREA
func _on_Detector_body_entered(body):
	if body is MainCharacter:
		var node:MainCharacter = body
		if _player_owner != null: return
		_player_owner = node;
		print("(BALL)OnDetectorAreaEnter: ", _player_owner)
	pass


## EXIT ON DETECTOR AREA
func _on_Detector_body_exited(body):
	if body is MainCharacter:
		var node:MainCharacter = body
		if(_player_owner == node):
			_player_owner = null
			print("(BALL)OnDetectorAreaExit: bye ")
	pass # Replace with function body.


##PLAYER INTERACTIONS
func strike(valid:Node2D, target:Node2D):
	if(valid != _body_touch): return
	print("(58) Ball: STRIKE VALID!")
	_strike(target)


## PHYSICS
func _strike(target:Node2D):
	var direction:Vector2 = target.position.direction_to(position)
	linear_velocity = direction * _BOUNCE_FORCE


## DISABLE INTERACTIONS WITH PLAYERS
func _disable_inteactions(time):
	pass

## INTERACTUABLE FUNCTS
func _check_interactuable():
	if(_is_interactuable): return
	_is_interactuable = OS.get_unix_time() > _time_to_interactuable
	pass

## RESET POSITION
func reset_pos():
	_is_reset = true
	pass


func _integrate_forces(state):
	if _is_reset:
		state.transform = Transform2D(0, _start_position)
		state.linear_velocity = Vector2()
		_is_reset = false
