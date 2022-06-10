extends Control

func on_transition():
	self.visible = true
	$AnimationPlayer.play("transition")
	yield(get_tree().create_timer(4),"timeout")
	self.hide()
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("on_transition",self,"on_transition")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
