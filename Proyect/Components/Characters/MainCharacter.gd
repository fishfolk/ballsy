extends KinematicBody2D
class_name MainCharacter


export var team:int = 0
export var active :bool = true
var speed: float = 6
var is_controlled:bool = false
var _is_walking:bool = false
var _ball = null

var _target_move:Vector2 


func pass_ball(target:Node2D):
	if _ball == null: return
	var direction:Vector2 = _ball.position.direction_to(target.position)
	var distance:float = self.position.distance_to(target.position)
	var force = direction * (distance * 2 + 100)
	_ball.make_pass(force,self)

func _ready():
	_target_move = Data.get_random_field_coord()

	$AnimationPlayer.play("Idle")
	speed *= 1000
	pass 


func _physics_process(delta):
	if not active: return
	if(is_controlled):
		_human_move(delta)
		return
	_machine_move(delta)


func _process(_delta):
	if not active: return
	if _is_walking:
		$AnimationPlayer.play("Walk")
	else: $AnimationPlayer.play("Idle")


	if(is_controlled):
		_strike()
		return
	_machine_pass()


func _machine_pass():
	pass

func _machine_move(delta):
	var distance = position.distance_to(_target_move)
	var dir = position.direction_to(_target_move)
	if distance < 100 : dir = Vector2.ZERO
	_move_to(delta, dir)
	pass

func _strike():
	if not Input.is_action_just_pressed("strike_to_arch"):
		return
	
	pass


func _activate_hablility():
	pass


func _human_move(delta):
	var horizontal_axis:float = Input.get_axis("horizontal_left","horizontal_rigth")
	var vertical_axis:float = Input.get_axis("vertical_down", "vertical_up")
	_move_to(delta, Vector2(horizontal_axis,-vertical_axis))


func _move_to(delta, dir):
	_is_walking =not (dir.x == 0 and dir.y == 0)
	if not _is_walking:
		return
	$Sprite.flip_h = not dir.x >= 0

	var horizontal_velocity:Vector2 = speed * Vector2(1,0) * dir.x * delta
	var vertical_velocity:Vector2 = speed * Vector2(0,1) * dir.y * delta
# warning-ignore:return_value_discarded
	move_and_slide(horizontal_velocity + (vertical_velocity), Vector2.UP)


func _on_Area2D_body_entered(body):

# Pasar la delegacion a la pelota
	if body.name == "Ball":
		
		var ball = body
		ball.set_last_player_touched(self)
		
	pass # Replace with function body.
