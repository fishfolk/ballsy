extends Control
class_name ScoreBoard

var score_label:Label

var timeLabel:Label

var _time_in_seconds:float = 600



func _display_time():
	var _time_int:int =  int(floor(_time_in_seconds))
	var _minutes:int = int(floor(_time_in_seconds / 60))
	var _seconds:int = _time_int % 60
	timeLabel.text = str("[",_minutes, " : ", _seconds, "]")
	pass

func display_score(_score:Vector2):
	score_label.text = str("[",_score.x, " - ", _score.y, "]")
	pass

func _ready():
	Globals.score_board = self
	score_label = $CenterContainer/AspectRatioContainer/VBoxContainer/CenterContainer/ScoreLabel
	timeLabel = $CenterContainer/AspectRatioContainer/VBoxContainer/CenterContainer2/TimeLabel

func _process(delta):
	_time_in_seconds -= delta
	_display_time()
