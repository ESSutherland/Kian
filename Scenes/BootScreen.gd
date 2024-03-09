extends Control

func _ready():
	Config.current_lb = Config.public_lb
	
	SilentWolf.configure({
	"api_key": Config.key,
	"game_id": Config.id,
	"game_version": "1.0.2",
	"log_level": 1
	})

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Game.tscn")
