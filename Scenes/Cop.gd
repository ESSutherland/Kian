extends StaticBody2D

var skins = ["perkins", "briddle", "holiday", "byson", "toretti"]

onready var sprite = $AnimatedSprite
onready var score_scene = preload("res://Scenes/ScoreEffect.tscn")
var rng = RandomNumberGenerator.new()
var cop
var copNode
onready var alive = true

func _ready():
	rng.randomize()
	var num = rng.randi_range(0, skins.size()-1)
	cop = skins[num]
	sprite.play(cop)
	
	if cop == 'byson':
		copNode = $Byson
	elif cop == 'briddle':
		copNode = $Briddle
	elif cop == 'holiday':
		copNode = $Holiday
	elif cop == 'perkins':
		copNode = $Perkins
	elif cop == 'toretti':
		copNode = $Toretti
	elif cop == 'peach':
		copNode = $Peach

func dead():
	alive = false
	var scoreAnim = score_scene.instance()
	scoreAnim.init("+10")
	add_child(scoreAnim)
	$CollisionShape2D.disabled = true
	$WarnArea.queue_free()
	play_Death_Sound()
	$Timer.start()
	$Shadow.hide()
	sprite.stop()
	$DeadTimer.start()
	PlayerVars.score += 10

func play_Death_Sound():
	rng.randomize()
	var num = rng.randi_range(1,2)
	copNode.get_node("Cuffs").stop()
	copNode.get_node("Resist").stop()
	if num % 2 == 0:
		copNode.get_node("Death1").play()
	else:
		copNode.get_node("Death2").play()

func _on_Timer_timeout():
	queue_free()


func _on_DeadTimer_timeout():
	sprite.rotate(90 * (PI/180))


func _on_WarnArea_body_entered(body):
	if alive and body.is_in_group("Player"):
		rng.randomize()
		var num = rng.randi_range(1,2)
		if num % 2 == 0:
			copNode.get_node("Cuffs").play()
		else:
			copNode.get_node("Resist").play()
