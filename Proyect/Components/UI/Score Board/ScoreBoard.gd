extends Control
class_name ScoreBoard

var score_label:Label

var timeLabel:Label

export var time_match:float = 60
var _time_in_seconds:float = 30



func _display_time():
	var _time_int:int =  int(floor(_time_in_seconds))
	var _minutes:int = int(floor(_time_in_seconds / 60))
	var _seconds:int = _time_int % 60
	timeLabel.text = str("[",_minutes, " : ", _seconds, "]")
	pass

func on_goal():
	var _score:Vector2 = Data.score
	score_label.text = str("[",_score.x, " - ", _score.y, "]")
	pass


func on_match_start():
	_time_in_seconds = time_match
	_display_time()
	on_goal()
	pass



func _ready():
	score_label = $CenterContainer/AspectRatioContainer/VBoxContainer/CenterContainer/ScoreLabel
	timeLabel = $CenterContainer/AspectRatioContainer/VBoxContainer/CenterContainer2/TimeLabel
	Globals.score_board = self
	Signals.connect("on_goal",self,"on_goal")
	Signals.connect("on_match_start",self,"on_match_start")
	on_match_start()
	_display_time()

func _process(delta):
	if(!Globals.in_match): return
	_time_in_seconds -= delta
	_time_in_seconds = clamp(_time_in_seconds,0,_time_in_seconds)
	_display_time()
	if _time_in_seconds <= 0: Signals.emit_signal("on_match_end")
