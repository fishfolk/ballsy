extends Node

var game
var score_board
var goalAnim
var main_scene
var timescale:float = 1
var in_match:bool = false

func on_match_start():
	yield(get_tree().create_timer(1),"timeout")
	in_match = true

func on_match_end():
	in_match = false

func _ready():
	Signals.connect("on_match_start",self,"on_match_start")
	Signals.connect("on_match_end",self,"on_match_end")
	pass
