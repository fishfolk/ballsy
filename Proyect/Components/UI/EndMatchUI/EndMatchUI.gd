extends Control

onready var animation = get_node("Animation")
onready var result_label = get_node("Panel/ResultLabel")
onready var winner_label = get_node("Panel/WinnerLabel")
onready var wistle_sound = get_node("WistleSound")
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("on_match_end",self,"on_match_end")
	pass # Replace with function body.

func on_match_end():
	animation.play("OpenWinBoard")
	result_label.text = str("P1 ",Data.score.x, " - ", Data.score.y, " P2")
	var winner = "P1"
	if Data.score.y > Data.score.x : winner = "P2"
	else: if Data.score.y == Data.score.x : winner = "Tie"
	winner_label.text = str("Winner: ", winner)
	wistle_sound.play()
	pass




func _on_BackMainMenu_button_down():
	animation.play("CloseEndMatch")
	Signals.emit_signal("on_transition")
	yield(get_tree().create_timer(1.1),"timeout")
	Globals.main_scene.show_main_menu()
	
	pass # Replace with function body.
