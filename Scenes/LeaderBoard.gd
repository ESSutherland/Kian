extends VBoxContainer

onready var dynamic_font = DynamicFont.new()

func _ready():
	yield(SilentWolf.Scores.get_high_scores(0, Config.current_lb), "sw_scores_received")
	dynamic_font.font_data = load("res://Assets/joystix monospace.ttf")
	dynamic_font.size = 32
	
	for i in range(0, 10):
		var label: Label = Label.new()
		var numLabel: Label = Label.new()
		var hBox: HBoxContainer = HBoxContainer.new()
		label.add_font_override("font", dynamic_font)
		numLabel.add_font_override("font", dynamic_font)
		numLabel.ALIGN_RIGHT
		var scores = SilentWolf.Scores.scores
		var s = scores[i] if len(scores) >= i+1 else null
		if i+1 < 10:
			numLabel.text = " " + str(i+1) + " "
		else:
			numLabel.text = str(i+1) + " "
		if s:
			label.text = s.player_name + ": " + str(s.score)
		else:
			label.text =  "------"
		hBox.add_child(numLabel)
		hBox.add_child(label)
		self.add_child(hBox)
