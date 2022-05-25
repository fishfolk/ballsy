extends KinematicBody2D
class_name MainCharacter


var speed: float = 6;
var is_controlled:bool = false;
export var team:int = 0;
var _is_walking:bool = false;

var dir:Vector2 = Vector2(1,0);

func _ready():
	$AnimationPlayer.play("Idle")
	speed *= 1000
	pass 


func _physics_process(delta):
	if(is_controlled):
		_human_move(delta)
		return
	_machine_move(delta)


func _process(delta):
	if _is_walking:
		$AnimationPlayer.play("Walk")
	else: $AnimationPlayer.play("Idle")


	if(is_controlled):
		_pass_ball()
		_strike()
		return
	_machine_pass()


func _machine_pass():
	pass

func _machine_move(delta):
	_move_to(delta, Vector2(0,0))
	pass

func _strike():
	pass

func _pass_ball():
	pass


func _activate_hablility():
	pass


func _human_move(delta):
	var horizontal_axis:float = Input.get_axis("horizontal_left","horizontal_rigth")
	var vertical_axis:float = Input.get_axis("vertical_down", "vertical_up")
	_move_to(delta, Vector2(horizontal_axis,vertical_axis))


func _move_to(delta, dir):
	_is_walking =not (dir.x == 0 and dir.y == 0)
	if not _is_walking:
		return
	$Sprite.flip_h = not dir.x >= 0

	
	var horizontal:Vector2 = transform.basis_xform(Vector2(1,0))
	var vertical:Vector2 = transform.basis_xform(Vector2(0,-1))
	var horizontal_velocity:Vector2 = speed * horizontal * dir.x * delta;
	var vertical_velocity:Vector2 = speed * vertical * dir.y * delta;
	move_and_slide(horizontal_velocity + (vertical_velocity / 1.5), Vector2.UP)


func _on_Area2D_body_entered(body):

# Pasar la delegacion a la pelota
	if body.name == "Ball":
		
		var ball = body
		ball.set_last_player_touched(self)
		
	pass # Replace with function body.
