extends Control

onready var effectSlider = $Vol
onready var effectLabel  = $ValueLabel

onready var effectBus = AudioServer.get_bus_index("Effects")

func _ready():
	effectSlider.value = PlayerVars.effectsVol
	effectLabel.text = str(PlayerVars.effectsVol*100)
	AudioServer.set_bus_volume_db(effectBus,linear2db(PlayerVars.effectsVol))

func _on_Vol_mouse_exited():
	effectSlider.release_focus()

func _on_Vol_value_changed(value):
	PlayerVars.effectsVol = value
	effectLabel.text = str(value*100)
	AudioServer.set_bus_volume_db(effectBus,linear2db(PlayerVars.effectsVol))
