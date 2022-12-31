extends Node2D

onready var ground_scene = preload("res://Scenes/Ground.tscn")
onready var bg_scene = preload("res://Scenes/Background.tscn")
onready var current_ground = $Ground
onready var current_bg = $Background

onready var player = $Player
onready var shadow = $Shadow

onready var score_label = $HUD/Score

func _ready():
	PlayerVars.score = 0
	PlayerVars.alive = true
	score_label.text = str(PlayerVars.score)
	
	if PlayerVars.music and not $Music.playing:
		$Music.play()
	
	$HUD/Ammo.text = str(player.ammo)
	$HUD/MaxAmmo.text = "/" + str(player.max_ammo)
	
	$Player.movement_enabled = false
	$Player.shooting_enabled = false
	$StartScreen.show()
	$HUD.hide()

func _physics_process(delta):
	var camera_x = $Player/Camera2D.global_position.x
	$Clouds.position.x = camera_x
	score_label.text = str(PlayerVars.score)
	$HUD/Ammo.text = str(player.ammo)
	shadow.global_position.x = player.global_position.x
	
	PlayerVars.wanted = min(PlayerVars.score/2, 120)
	
	if not PlayerVars.music:
		$StartScreen/MusicButton.icon = load("res://Assets/music_off.png")
	else:
		$StartScreen/MusicButton.icon = load("res://Assets/music_on.png")
	
	if not PlayerVars.alive:
		$HUD.hide()
		$EndScreen/Score.text = str(PlayerVars.score)
		$EndScreen.show()

func _on_SpawnArea_body_entered(body):
	if body.is_in_group("Ground"):
		var end = current_ground.get_child(current_ground.get_child_count()-1)
		var new_ground = ground_scene.instance()
		new_ground.call_deferred("set", "position", end.global_position)
		call_deferred("add_child", new_ground)
		current_ground = new_ground
	elif body.is_in_group("Background"):
		var end = current_bg.get_child(current_bg.get_child_count()-1)
		var new_bg = bg_scene.instance()
		new_bg.call_deferred("set", "position", end.global_position)
		call_deferred("add_child", new_bg)
		current_bg = new_bg


func _on_Timer_timeout():
	if PlayerVars.alive:
		PlayerVars.score += 1


func _on_StartButton_pressed():
	$StartScreen.hide()
	$Player.movement_enabled = true
	$Player.shooting_enabled = true
	$Player/AnimatedSprite.play("run")
	$Timer.start()
	$HUD.show()


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_MusicButton_pressed():
	if PlayerVars.music:
		PlayerVars.music = false
		$Music.stop()
	else:
		PlayerVars.music = true
		$Music.play()
