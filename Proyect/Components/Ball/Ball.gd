extends RigidBody2D
class_name Ball


export var rotation_speed:float = 0.15

var last_player_touched:Node2D = null

var timestamp:float
var time_to:float
var cd:float = 3

func set_last_player_touched(node):
	last_player_touched = node


func _ready():
	timestamp = OS.get_unix_time()
	add_Time()
	pass

func add_Time():
	time_to = timestamp + cd

func _process(delta):
	timestamp = OS.get_unix_time()

func _physics_process(delta):
	var speed = linear_velocity.x
	var sprite = $CollisionShape2D/Sprite
	var rotation = rotation_speed * speed * delta
	sprite.transform = sprite.transform.rotated(rotation)

func make_strike(force , node):

	if node != last_player_touched: 
		return

	linear_velocity += force
	linear_velocity = Vector2(clamp(linear_velocity.x, -450, 450), clamp(linear_velocity.y, -450, 450))

func make_pass_to_character(target_node , node):
	if time_to > timestamp: return
	add_Time()
	var dir = position.direction_to(target_node.position)
	var distance = position.distance_to(target_node.position)
	var force = (dir * 50) + (dir * 250 * distance)
	make_pass(force , node)

func make_pass(force , node):
	make_strike(force , node)
	last_player_touched = null


func _on_Detector_body_entered(body):
	if body is MainCharacter:
		last_player_touched = body
		body._ball = self
		var direction =  position.direction_to(body.position)
		make_strike(-direction * 250, body)

