extends Node

@onready var music_player = $MusicPlayer
@onready var click_player = $ClickPlayer

func _ready() -> void:
	music_player.play()

func play_click() -> void:
	click_player.play()
