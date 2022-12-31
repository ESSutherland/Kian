extends KinematicBody2D

export var gravity = 80

var velocity = Vector2(0, 0)
var movement_enabled = true
var shooting_enabled = true
var max_ammo = 8
var ammo = max_ammo

onready var bullet_scene = preload("res://Scenes/Bullet.tscn")

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
		if collision.collider.is_in_group("Barricade") or collision.collider.is_in_group("Cop") and PlayerVars.alive:
			velocity = Vector2.ZERO
			movement_enabled = false
			shooting_enabled = false
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
			shooting_enabled = false
			$Gun/GunSound.play()
			$Gun/Timer.start()
		else:
			$Gun/Empty.play()
			$Gun/Timer.start()
	
	if Input.is_action_just_pressed("reload") and shooting_enabled and ammo < max_ammo:
		ammo = max_ammo
		$Gun/Reload.play()
		$Gun/Timer.start()

func _on_Timer_timeout():
	if PlayerVars.alive:
		shooting_enabled = true
