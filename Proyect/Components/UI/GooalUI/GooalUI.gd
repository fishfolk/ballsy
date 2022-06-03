extends Control

class_name GoalUI


func play():
	$AnimationPlayer.play("GoalUIAnim")

	
func _ready():
	Globals.goalAnim = self
	pass
