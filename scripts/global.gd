extends Node

var settingsMenuOpen: bool = false

#var settings_data = {}
var settingsConfig: ConfigFile = ConfigFile.new()
var musicVol:int = 0
var soundFxVol: int = 0
var shakeEnabled: bool = true
@onready var musicBus: int = AudioServer.get_bus_index("Music")
@onready var soundFxBus: int = AudioServer.get_bus_index("SoundFX")


func _ready() -> void:
	load_settings()


func load_settings() -> void:
	var err: int = settingsConfig.load("user://settings.cfg")
	Debug.print_type_of(err, "err")
	print(err)
	#print(OS.get_data_dir())
	if err != OK:
		print("no config file found... loading defaults")
		settings_to_default()
	else:
		musicVol = settingsConfig.get_value("Settings", "music_volume")
		soundFxVol = settingsConfig.get_value("Settings", "soundFx_volume")
		shakeEnabled = settingsConfig.get_value("Settings", "shake_enabled")
		print("Music Volume on load is: " + str(musicVol))
		print("SoundFX Volume on load is " + str (soundFxVol))
		print("Shake Enabled on load is " + str(shakeEnabled))
		AudioServer.set_bus_volume_db(musicBus, musicVol)
		AudioServer.set_bus_volume_db(soundFxBus, soundFxVol)


func settings_to_default() -> void:
	settingsConfig.set_value("Settings", "soundFx_volume", 0)
	settingsConfig.set_value("Settings", "music_volume", 0)
	settingsConfig.set_value("Settings", "shake_enabled", true)
	settingsConfig.save("user://settings.cfg")
	
