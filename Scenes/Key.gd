extends Area2D

func _ready():
	pass # Replace with function body.


func _on_Key_body_entered(body):
	if body.is_in_group("Player"):
		PlayerVars.hasCollectedKey = true
		PlayerVars.hasKey = true
		body.getKey()
		queue_free()
