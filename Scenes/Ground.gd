extends StaticBody2D

export var can_spawn = true
onready var spawners = $Spawners
onready var powerUps = $PowerUp
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var cop_scene = preload("res://Scenes/Cop.tscn")
	var barr_scene = preload("res://Scenes/Barricade.tscn")
	var civ_scene = preload("res://Scenes/Civ.tscn")
	var key_scene = preload("res://Scenes/Key.tscn")
	var spawner_list = spawners.get_children()
	var power_list = powerUps.get_children()
	if can_spawn: 
		for i in range(0, spawner_list.size()):
			var spawn_chance = rng.randi_range(0, 100)
			
			var rate = 2
			
			if spawn_chance % rate == 0:
				var cop = cop_scene.instance()
				var barricade = barr_scene.instance()
				var civ = civ_scene.instance()
				var chance = rng.randi_range(1, 100)
				if chance < 40:
					spawner_list[i].call_deferred("add_child", cop)
				elif chance < 90:
					spawner_list[i].call_deferred("add_child", barricade)
				elif chance <= 100:
					spawner_list[i].call_deferred("add_child", civ)
				else:
					pass
		
		if not PlayerVars.hasCollectedKey:
			var key = key_scene.instance()
			rng.randomize()
			var num = rng.randi_range(0,100)
			if num == 69:
				rng.randomize()
				var num2 = rng.randi_range(0, 2)
				#power_list[num2].call_deferred("add_child", key)
				


func _on_DespawnTimer_timeout():
	if PlayerVars.alive:
		queue_free()
