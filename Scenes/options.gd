extends Control


@onready var master_volume_slider = $OptionsPanel/Margins/Content/SettingsList/MasterVolumeSlider
@onready var music_volume_slider = $OptionsPanel/Margins/Content/SettingsList/MusicVolumeSlider
@onready var fullscreen_button = $OptionsPanel/Margins/Content/SettingsList/FullscreenButton
@onready var sound_button = $OptionsPanel/Margins/Content/SettingsList/SoundButton
@onready var reset_button = $OptionsPanel/Margins/Content/SettingsList/ResetButton
@onready var back_button = $OptionsPanel/Margins/Content/SettingsList/BackButton


func _ready() -> void:
	master_volume_slider.value = 80
	music_volume_slider.value = 70
	
	fullscreen_button.button_pressed = false
	sound_button.button_pressed = true


func _on_master_volume_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(0, volume_db)


func _on_music_volume_slider_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value / 100.0)
	AudioServer.set_bus_volume_db(0, volume_db)


func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	print("BUTTON SIGNAL:", toggled_on)

	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)



func _on_sound_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, not toggled_on)


func _on_reset_button_pressed() -> void:
	master_volume_slider.value = 80
	music_volume_slider.value = 70
	fullscreen_button.button_pressed = false
	sound_button.button_pressed = true


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
