extends StaticBody2D

onready var score_scene = preload("res://Scenes/ScoreEffect.tscn")
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	if sprite.playing:
		if sprite.frame == 0:
			$BlueLight.show()
			$RedLight.hide()
		else:
			$BlueLight.hide()
			$RedLight.show()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		var scoreAnim = score_scene.instance()
		scoreAnim.init("+10")
		scoreAnim.position.x += 100
		add_child(scoreAnim)
		PlayerVars.score += 10
