extends StaticBody2D

export var can_spawn = true
onready var spawners = $Spawners
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var cop_scene = preload("res://Scenes/Cop.tscn")
	var barr_scene = preload("res://Scenes/Barricade.tscn")
	var spawner_list = spawners.get_children()
	if can_spawn: 
		for i in range(0, spawner_list.size()):
			var spawn_chance = int(floor(rng.randf_range(0, 100)))
			if spawn_chance % 3 == 0:
				var cop = cop_scene.instance()
				var barricade = barr_scene.instance()
				var chance = int(floor(rng.randf_range(0, 100)))
				if chance % 2 == 0:
					spawner_list[i].call_deferred("add_child", cop)
				else:
					spawner_list[i].call_deferred("add_child", barricade)
