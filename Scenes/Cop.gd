extends StaticBody2D

var skins = ["perkins", "briddle", "holiday", "byson"]

onready var sprite = $AnimatedSprite
var rng = RandomNumberGenerator.new()
var cop
onready var alive = true

func _ready():
	rng.randomize()
	var num = floor(rng.randf_range(0, skins.size()))
	cop = skins[num]
	sprite.play(cop)

func dead():
	alive = false
	$CollisionShape2D.disabled = true
	$WarnArea.queue_free()
	play_Death_Sound()
	$Timer.start()
	$Shadow.hide()
	sprite.stop()
	$DeadTimer.start()
	PlayerVars.score += 10

func play_Death_Sound():
	rng.randomize()
	var num = int(floor(rng.randf() * 100))
	if num % 2 == 0:
		if cop == "byson":
			$Byson/Cuffs.stop()
			$Byson/Resist.stop()
			$Byson/Death1.play()
		elif cop == 'briddle':
			$Briddle/Cuffs.stop()
			$Briddle/Resist.stop()
			$Briddle/Death1.play()
		elif cop == 'holiday':
			$Holiday/Cuffs.stop()
			$Holiday/Resist.stop()
			$Holiday/Death1.play()
		elif cop == 'perkins':
			$Perkins/Cuffs.stop()
			$Perkins/Resist.stop()
			$Perkins/Death1.play()

	else:
		if cop == "byson":
			$Byson/Cuffs.stop()
			$Byson/Resist.stop()
			$Byson/Death2.play()
		elif cop == 'briddle':
			$Briddle/Cuffs.stop()
			$Briddle/Resist.stop()
			$Briddle/Death2.play()
		elif cop == 'holiday':
			$Holiday/Cuffs.stop()
			$Holiday/Resist.stop()
			$Holiday/Death2.play()
		elif cop == 'perkins':
			$Perkins/Cuffs.stop()
			$Perkins/Resist.stop()
			$Perkins/Death2.play()

func _on_Timer_timeout():
	queue_free()


func _on_DeadTimer_timeout():
	sprite.rotate(90 * (PI/180))


func _on_WarnArea_body_entered(body):
	if alive and body.is_in_group("Player"):
		rng.randomize()
		var num = int(floor(rng.randf() * 100))
		if num % 2 == 0:
			if cop == "byson":
				$Byson/Cuffs.play()
			elif cop == 'briddle':
				$Briddle/Cuffs.play()
			elif cop == 'holiday':
				$Holiday/Cuffs.play()
			elif cop == 'perkins':
				$Perkins/Cuffs.play()
		else:
			if cop == "byson":
				$Byson/Resist.play()
			elif cop == 'briddle':
				$Briddle/Resist.play()
			elif cop == 'holiday':
				$Holiday/Resist.play()
			elif cop == 'perkins':
				$Perkins/Resist.play()
