extends Control

class_name MainScene

var game_asset = preload("res://GameScene/Game.tscn")
var game


func start_versus_game():
	Signals.emit_signal("on_transition")
	game = game_asset.instance()
	yield(get_tree().create_timer(1.0),"timeout")
	self.add_child(game)
	self.move_child(game,0)
	$MainMenu.hide()
	yield(get_tree().create_timer(2.0),"timeout")
	Signals.emit_signal("on_match_start")


func show_main_menu():
	$MainMenu.visible = true
	game.queue_free()
	
func _ready():
	Signals.connect("start_versus",self,"start_versus_game")
	Globals.main_scene = self

