extends Node2D

onready var ground_scene = preload("res://Scenes/Ground.tscn")
onready var bg_scene = preload("res://Scenes/Background.tscn")
onready var current_ground = $Ground
onready var current_bg = $Background

onready var player = $Player
onready var shadow = $Shadow

onready var score_label = $HUD/Score

var restartPressed

func _ready():
	PlayerVars.score = 0
	PlayerVars.alive = true
	score_label.text = str(PlayerVars.score)
	
	$HUD/Ammo.text = str(player.ammo)
	$HUD/MaxAmmo.text = "/" + str(player.max_ammo)
	
	restartPressed = false
	
	$Player.movement_enabled = false
	$Player.shooting_enabled = false
	if PlayerVars.nameSelected:
		$StartScreen.show()
	else:
		$PlayerNameScreen.show()
	$HUD.hide()
	
	$Music.play()

func _physics_process(delta):
	var camera_x = $Player/Camera2D.global_position.x
	$Clouds.position.x = camera_x
	score_label.text = str(PlayerVars.score)
	$HUD/Ammo.text = str(player.ammo)
	shadow.global_position.x = player.global_position.x
	
	PlayerVars.wanted = min(PlayerVars.score/2, 120)
	
	if not PlayerVars.alive:
		$HUD.hide()
		$EndScreen/ScoreLabel.text = ("SCORE:" + str(PlayerVars.score))
		$EndScreen.show()
	
func _on_SpawnArea_body_entered(body):
	if body.is_in_group("Ground"):
		var end = current_ground.get_node("EndPos")
		var new_ground = ground_scene.instance()
		new_ground.call_deferred("set", "position", end.global_position)
		call_deferred("add_child", new_ground)
		current_ground.get_node("DespawnTimer").start()
		current_ground = new_ground
	elif body.is_in_group("Background"):
		var end = current_bg.get_node("EndPos")
		var new_bg = bg_scene.instance()
		new_bg.call_deferred("set", "position", end.global_position)
		call_deferred("add_child", new_bg)
		current_ground.get_node("DespawnTimer").start()
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
	if not restartPressed:
		restartPressed = true
		var scoreId = yield(SilentWolf.Scores.persist_score(PlayerVars.playerName, PlayerVars.score, Config.current_lb), "sw_score_posted")
		get_tree().change_scene("res://Scenes/Game.tscn")


func _on_OptionsButton_pressed():
	$StartScreen.hide()
	$OptionsScreen.show()


func _on_MenuButton_pressed():
	$OptionsScreen.hide()
	$HowToPlayScreen.hide()
	$HowToPlayScreen.hide()
	$LeaderBoardScreen.hide()
	$CharactersScreen.hide()
	$StartScreen.show()


func _on_HowToPlay_pressed():
	$StartScreen.hide()
	$HowToPlayScreen.show()


func _on_SubmitButton_pressed():
	PlayerVars.playerName = $PlayerNameScreen/PlayerName.text
	PlayerVars.nameSelected = true
	$PlayerNameScreen.hide()
	$StartScreen.show()


func _on_LeaderboardButton_pressed():
	if PlayerVars.playerName == Config.admin:
		$LeaderBoardScreen/ResetLBButton.show()
	$StartScreen.hide()
	$LeaderBoardScreen.show()


func _on_CharactersButton_pressed():
	$StartScreen.hide()
	$CharactersScreen.show()


func _on_ResetLBButton_pressed():
	SilentWolf.Scores.wipe_leaderboard(Config.current_lb)
