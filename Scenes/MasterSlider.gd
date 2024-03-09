extends Control

onready var masterSlider = $Vol
onready var masterLabel  = $ValueLabel

onready var masterBus = AudioServer.get_bus_index("Master")

func _ready():
	masterSlider.value = PlayerVars.masterVol
	masterLabel.text = str(PlayerVars.masterVol*100)
	AudioServer.set_bus_volume_db(masterBus,linear2db(PlayerVars.masterVol))

func _on_Vol_mouse_exited():
	masterSlider.release_focus()

func _on_Vol_value_changed(value):
	PlayerVars.masterVol = value
	masterLabel.text = str(value*100)
	AudioServer.set_bus_volume_db(masterBus,linear2db(PlayerVars.masterVol))
