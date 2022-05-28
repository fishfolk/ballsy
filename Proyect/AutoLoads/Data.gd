extends Node

var field_dimsx = Vector2(107, 878)
var field_dimsy = Vector2(82, 466)

func get_random_field_coord():
	randomize()
	var size = Vector2(field_dimsx.y - field_dimsx.x, field_dimsy.y - field_dimsy.x)
	var coord = Vector2(field_dimsx.x + randi() % int(size.x),field_dimsy.x + randi() % int(size.y))
	return coord
