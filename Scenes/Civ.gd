extends StaticBody2D

onready var score_scene = preload("res://Scenes/ScoreEffect.tscn")
onready var alive = true
onready var sprite = $AnimatedSprite

var skins = ["hades", "max", "andi"]
var rng = RandomNumberGenerator.new()
var civ
var civNode

func _ready():
	rng.randomize()
	var num = rng.randi_range(0, skins.size()-1)
	civ = skins[num]
	sprite.play(civ)
	
	if civ == 'andi':
		civNode = $Andi
	elif civ == 'hades':
		civNode = $Hades
	elif civ == 'max':
		civNode = $Max

func dead():
	alive = false
	var scoreAnim = score_scene.instance()
	scoreAnim.init("-20")
	scoreAnim.makeRed()
	add_child(scoreAnim)
	$CollisionShape2D.disabled = true
	play_Death_Sound()
	$Timer.start()
	$Shadow.hide()
	sprite.stop()
	$DeadTimer.start()
	PlayerVars.score = max(0, PlayerVars.score - 20)

func play_Death_Sound():
	rng.randomize()
	var num = rng.randi_range(1,2)
	if num%2 == 0:
		civNode.get_node("Death1").play()
	else:
		civNode.get_node("Death2").play()
	

func _on_Timer_timeout():
	queue_free()


func _on_DeadTimer_timeout():
	sprite.rotate(90 * (PI/180))


func _on_WarnArea_body_entered(body):
	if alive and body.is_in_group("Player"):
		rng.randomize()
		var num = rng.randi_range(1,10)
		if num == 5:
			civNode.get_node("Hello").play()
