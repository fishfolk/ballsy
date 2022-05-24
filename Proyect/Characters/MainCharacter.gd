extends KinematicBody2D

var speed: float = 6;
export var is_controlled:bool = false;

#Return the Distance Absolute between thsi node and vector2 b 
func get_distace(b:Vector2):
	return(_get_raw_distance(b).abs())


func _get_raw_distance(b:Vector2):
	var result:Vector2 = transform.origin - b;
	return result


#Return vector2 Normalized pointed to object
func get_direction(target):
	var result:Vector2 = _get_raw_distance(target).normalized()
	return result
	



var dir:Vector2 = Vector2(1,0);


func _ready():
	speed *= 1000
	pass 


func _process(delta):
	if(!is_controlled): return
	var horizontal_axis:float = Input.get_axis("horizontal_left","horizontal_rigth")
	var vertical_axis:float = Input.get_axis("vertical_down", "vertical_up")
	var horizontal = transform.basis_xform(Vector2(1,0))
	var vertical = transform.basis_xform(Vector2(0,-1))
	if horizontal_axis != 0:
		dir = Vector2(horizontal_axis, vertical_axis)
	var horizontal_velocity = speed * horizontal * horizontal_axis * delta;
	var vertical_velocity = speed * vertical * vertical_axis * delta;
	
	move_and_slide(horizontal_velocity + (vertical_velocity / 1.5), Vector2.UP)
	pass


func _on_Area2D_body_entered(body):

# Pasar la delegacion a la pelota
	if body.name == "Ball":
		print(body.name)
		var ball = body
		ball.set_last_player_touched(self)
		var direction =  self.position.direction_to(ball.position) * Vector2(1,0)
		print(direction)

		
		ball.add_force(direction * 250, self)
	pass # Replace with function body.
