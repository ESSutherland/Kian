extends CanvasLayer

onready var textBox = $PlayerName

func _ready():
	textBox.text = PlayerVars.playerName

