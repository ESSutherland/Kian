extends Control

onready var musicSlider = $Vol
onready var musicLabel  = $ValueLabel

onready var musicBus = AudioServer.get_bus_index("Music")

func _ready():
	musicSlider.value = PlayerVars.musicVol
	musicLabel.text = str(PlayerVars.musicVol*100)
	AudioServer.set_bus_volume_db(musicBus,linear2db(PlayerVars.musicVol))

func _on_Vol_mouse_exited():
	musicSlider.release_focus()

func _on_Vol_value_changed(value):
	PlayerVars.musicVol = value
	musicLabel.text = str(value*100)
	AudioServer.set_bus_volume_db(musicBus,linear2db(PlayerVars.musicVol))
