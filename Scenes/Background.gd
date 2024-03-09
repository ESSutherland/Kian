extends StaticBody2D

func _on_DespawnTimer_timeout():
	if PlayerVars.alive:
		queue_free()
