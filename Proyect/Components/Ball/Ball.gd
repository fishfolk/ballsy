extends RigidBody2D
class_name Ball

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

func _ready():
	linear_damp = _DAMP
	pass

func set_target(target:Node2D):
	_target = target

func _process(delta):
	
	_check_distnace_to_body()
	
	pass

func _physics_process(delta):
	if (_target == null): return
	var direction:Vector2 = _target.position.direction_to(position)
	linear_velocity = direction * (_BOUNCE_FORCE * 0.5)
	pass



## TOUCH BODY FUNCTS
func _check_distnace_to_body():
	if(_body_touch == null): return
	var dist = position.distance_to(_body_touch.position)
	if(dist > _MAX_DISTANCE_TO_BODY):
		_body_touch = null
		print("(41) Ball: RELEASE")

func _on_Detector_body_entered(body):
	if body is MainCharacter:
		var node:Node2D = body
		_body_touch = body;
		print("(48) BAll: TOUCHED")
		_strike(node)
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


## INTERACTUABLE FUNCTS
func _check_interactuable():
	if(_is_interactuable): return
	_is_interactuable = OS.get_unix_time() > _time_to_interactuable
	_update_collision_shape()
	pass


func _update_collision_shape():
	if($"Detector/Detector Shape".disabled !=  _is_interactuable): return
	$"Detector/Detector Shape".disabled = not _is_interactuable
	print("(78) Ball interaction = ", $"Detector/Detector Shape".disabled)
	pass


func _disable_interaction(time_left:float = _default_time_not_interactuable):
	_is_interactuable = false
	_update_collision_shape()
	_time_to_interactuable = OS.get_unix_time() + time_left
	pass
