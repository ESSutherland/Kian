extends KinematicBody2D

export var gravity = 80

var velocity = Vector2(0, 0)
var movement_enabled = true
var shooting_enabled = true
var max_ammo = 8
var ammo = max_ammo

onready var bullet_scene = preload("res://Scenes/Bullet.tscn")
onready var score_scene = preload("res://Scenes/ScoreEffect.tscn")
onready var broken_scene = preload("res://Scenes/Broken.tscn")

func _physics_process(delta):
	
	if movement_enabled:
		velocity.x = 600 + PlayerVars.wanted
	
	if !$Running.playing and is_on_floor() and movement_enabled:
		$Running.play()
	
	if not is_on_floor() and movement_enabled:
		velocity.y += gravity
	else:
		if Input.is_action_just_pressed("jump") and movement_enabled:
			$Running.stop()
			velocity.y = -1400  
	
	move_and_slide(velocity, Vector2.UP)
	
	var collision = get_last_slide_collision()
	
	if collision != null:
		if (collision.collider.is_in_group("Barricade") or collision.collider.is_in_group("Cop")) and PlayerVars.alive:
			if PlayerVars.hasKey:
				collision.collider.queue_free()
				var brokenAnim = broken_scene.instance()
				add_child(brokenAnim)
			else:
				shooting_enabled = false
				velocity = Vector2.ZERO
				movement_enabled = false
				PlayerVars.alive = false
				$Handcuffs.play()
				$AnimatedSprite.stop()
				$Running.stop()

	if Input.is_action_just_pressed("shoot") and shooting_enabled:
		if ammo > 0:
			ammo -= 1
			$Gun/GunSmoke.emitting = true
			var bullet = bullet_scene.instance()
			bullet.global_position = $Gun.global_position
			get_parent().call_deferred("add_child", bullet)
			$Gun/GunLight.show()
			$Gun/GunLightTimer.start()
			shooting_enabled = false
			$Gun/GunSound.play()
			$Gun/Timer.start()
		else:
			$Gun/Empty.play()
			$Gun/Timer.start()
	
	if Input.is_action_just_pressed("reload") and shooting_enabled and ammo < max_ammo:
		PlayerVars.score = max(0, PlayerVars.score - ammo)
		if ammo > 0:
			var scoreAnim = score_scene.instance()
			scoreAnim.init("-"+str(ammo))
			scoreAnim.makeRed()
			add_child(scoreAnim)
		ammo = max_ammo
		$Gun/Reload.play()
		$Gun/Timer.start()

func getKey():
	var scoreAnim = score_scene.instance()
	scoreAnim.init('+KEY')
	add_child(scoreAnim)

func _on_Timer_timeout():
	if PlayerVars.alive:
		shooting_enabled = true


func _on_GunLightTimer_timeout():
	$Gun/GunLight.hide()
