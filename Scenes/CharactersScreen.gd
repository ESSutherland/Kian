extends CanvasLayer

var characters = ['kian', 'byson', 'briddle', 'holiday', 'perkins',
'toretti', 'andi', 'hades', 'max']

var currentIndex
var currentCharacter

func _ready():
	currentIndex = 0
	currentCharacter = characters[currentIndex]
	$PrevButton.hide()
	$NextButton.show()

func _physics_process(delta):
	
	$Character.animation = currentCharacter
	if currentCharacter == 'kian':
		$Name.text = 'Kian Mercer'
		$Type.text = 'Player'
		$Type.add_color_override("font_color", Color.purple)
		$Voice.text = ''
	elif currentCharacter == 'byson':
		$Name.text = 'Aaron Byson'
		$Type.text = 'Cop'
		$Type.add_color_override("font_color", Color.red)
		$Voice.text = 'Voice by: Aaron Byson'
	elif currentCharacter == 'briddle':
		$Name.text = 'Barry Briddle'
		$Type.text = 'Cop'
		$Type.add_color_override("font_color", Color.red)
		$Voice.text = 'Voice by: Barry Briddle'
	elif currentCharacter == 'holiday':
		$Name.text = 'Marco Holiday'
		$Type.text = 'Cop'
		$Type.add_color_override("font_color", Color.red)
		$Voice.text = 'Voice by: Julio Thomas'
	elif currentCharacter == 'perkins':
		$Name.text = 'Jerry Perkins'
		$Type.text = 'Cop'
		$Type.add_color_override("font_color", Color.red)
		$Voice.text = 'Voice by: Jerry Perkins'
	elif currentCharacter == 'toretti':
		$Name.text = 'Domenic Toretti'
		$Type.text = 'Cop'
		$Type.add_color_override("font_color", Color.red)
		$Voice.text = 'Voice by: Domenic Toretti'
	elif currentCharacter == 'peach':
		$Name.text = 'Peach Chee'
		$Type.text = 'Cop'
		$Type.add_color_override("font_color", Color.red)
		$Voice.text = 'Voice by: Peach Chee'
	elif currentCharacter == 'andi':
		$Name.text = 'Andi Jones'
		$Type.text = 'HOA'
		$Type.add_color_override("font_color", Color.orange)
		$Voice.text = 'Voice by: Andi Jones'
	elif currentCharacter == 'hades':
		$Name.text = 'Hades'
		$Type.text = 'HOA'
		$Type.add_color_override("font_color", Color.orange)
		$Voice.text = 'Voice by: Hades'
	elif currentCharacter == 'max':
		$Name.text = 'Maximillian Angel'
		$Type.text = 'Civilian'
		$Type.add_color_override("font_color", Color.skyblue)
		$Voice.text = 'Voice by: Maximillian Angel'


func _on_NextButton_pressed():
	if currentIndex < len(characters) - 1:
		currentIndex+=1
	
	currentCharacter = characters[currentIndex]
	
	if currentIndex > 0:
		$PrevButton.show()
	else:
		$PrevButton.hide()
	if currentIndex == len(characters) - 1:
		$NextButton.hide()
	else:
		$NextButton.show()


func _on_PrevButton_pressed():
	if currentIndex > 0:
		currentIndex -= 1
	
	currentCharacter = characters[currentIndex]
	
	if currentIndex > 0:
		$PrevButton.show()
	else:
		$PrevButton.hide()
	if currentIndex == len(characters) - 1:
		$NextButton.hide()
	else:
		$NextButton.show()
