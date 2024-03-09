extends KinematicBody2D

export var speed = 1500

var velocity = Vector2.ZERO

func _ready():
	velocity = Vector2(speed, 0)

func _physics_process(delta):
	move_and_slide(velocity)
	
	var collision = get_last_slide_collision()
	
	if collision != null:
		if collision.collider.is_in_group("Shootable"):
			velocity = Vector2.ZERO
			collision.collider.dead()
			$Sprite.hide()
			$CollisionShape2D.disabled = true
			$Blood.emitting = true

func _on_Timer_timeout():
	queue_free()
