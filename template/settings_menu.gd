extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var music_slider: HSlider = $InteractiveElements/MusicSlider
@onready var sound_fx_slider: HSlider = $InteractiveElements/SoundFXSlider
@onready var enable_shake_checkbox: CheckButton = $InteractiveElements/EnableShakeCheckbox
@onready var sound_percentage: Label = $Labels/SoundPercentage
@onready var music_percentage: Label = $Labels/MusicPercentage
@onready var musicBus: int = AudioServer.get_bus_index("Music")
@onready var soundFXBus: int = AudioServer.get_bus_index("SoundFX")
var musicVolume: float
var soundFxVolume: float
var soundPercentage: float
var musicPercentage: float


func _ready() -> void:
	Global.load_settings()
	set_settings_stage()
	animation_player.play("fade_in")


func set_settings_stage() -> void:
	Global.settingsMenuOpen = true
	musicVolume = Global.musicVol
	music_slider.value = musicVolume
	soundFxVolume = Global.soundFxVol
	sound_fx_slider.value = soundFxVolume
	if Global.shakeEnabled == true:
		enable_shake_checkbox.button_pressed = true
	else:
		enable_shake_checkbox.button_pressed = false
	calc_music_percentage(musicVolume)
	calc_soundFx_percentage(soundFxVolume)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBus, value)
	musicVolume = value
	calc_music_percentage(musicVolume)
	print(musicPercentage)

	
func calc_music_percentage(value: float) -> void:
	musicPercentage = (value - -80.0) / (0.0 - -80) * 100
	musicPercentage = int(musicPercentage)
	music_percentage.text = str(int(musicPercentage)) + " %"
	print(musicPercentage)
	

func _on_sound_fx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(soundFXBus, value)
	soundFxVolume = value
	calc_soundFx_percentage(soundFxVolume)
	print(soundPercentage)
	
	
func calc_soundFx_percentage(value: float) -> void:
	soundPercentage = (value - -80.0) / (0.0 - -80) * 100
	soundPercentage = int(soundPercentage)
	print(soundPercentage)
	sound_percentage.text = str(int(soundPercentage)) + " %"


func _on_enable_shake_checkbox_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		Global.shakeEnabled = true
	else:
		Global.shakeEnabled = false
	print(Global.shakeEnabled)
	

func _on_close_settings_pressed() -> void:
	Global.settingsMenuOpen = false
	SignalBus.settings_menu_close.emit()
	save_settings()
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	queue_free()


func save_settings() -> void:
	Global.settingsConfig.set_value("Settings", "music_volume", musicVolume)
	Global.settingsConfig.set_value("Settings", "soundFx_volume", soundFxVolume)
	Global.settingsConfig.set_value("Settings", "shake_enabled", Global.shakeEnabled)
	print("MUSIC VOLUME IS " + str(Global.settingsConfig.get_value("Settings", "music_volume")))
	print("SOUNDFX VOLUME IS " + str(Global.settingsConfig.get_value("Settings", "soundFx_volume")))
	print("SHAKE ENABLED STATUS " + str(Global.settingsConfig.get_value("Settings", "shake_enabled")))
	Global.settingsConfig.save("user://settings.cfg")
	
