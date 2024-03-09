extends Node2D

onready var anim = $ScoreAnimator
onready var scoreLabel = $Label

var labelText = ""

func _ready():
	anim.play("ScoreAnim")
	scoreLabel.text = labelText

func init(text):
	labelText = text

func makeRed():
	modulate = Color(1,0,0,1)

func _on_Timer_timeout():
	queue_free()
