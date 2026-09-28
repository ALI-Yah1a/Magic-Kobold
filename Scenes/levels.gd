extends Control

var current_level := 1
var total_levels := 7
var selected_level := 1
@onready var dots = [
	$LevelProgress/Dot1,
	$LevelProgress/Dot2,
	$LevelProgress/Dot3,
	$LevelProgress/Dot4,
	$LevelProgress/Dot5,
	]
@onready var level_counter = $LevelCounter

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_returnbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Transition.change_scene("res://Scenes/main_menu.tscn")
	AudioManager.play_click()

func _on_level_1_button_pressed() -> void:
	AudioManager.play_click()
	selected_level = 1
	$Level1Popup/LevelName.text = "Whispering Woods"
	$Level1Popup/DifficultyTitle.text = "DIFFICULTY"
	$Level1Popup/DifficultyStars.text = "★☆☆☆☆"
	$Level1Popup.show()
	$AnimationPlayer.play("level_popup_in")
	$QuitFade.show()

func _on_level_2_button_pressed() -> void:
	AudioManager.play_click()
	selected_level = 2
	$Level2Popup/LevelName.text = "Sunken Ruins of Kel'Dahr"
	$Level2Popup/DifficultyTitle.text = "DIFFICULTY"
	$Level2Popup/DifficultyStars.text = "★★☆☆☆"
	$Level2Popup.show()
	$AnimationPlayer.play("level_2_popup_in")
	$QuitFade.show()

func _on_level_3_button_pressed() -> void:
	AudioManager.play_click()
	selected_level = 3
	$Level3Popup/LevelName.text = "Echoing Caverns"
	$Level3Popup/DifficultyTitle.text = "DIFFICULTY"
	$Level3Popup/DifficultyStars.text = "★★★☆☆"
	$Level3Popup.show()
	$AnimationPlayer.play("level_3_popup_in")
	$QuitFade.show()

func _on_level_4_button_pressed() -> void:
	AudioManager.play_click()
	selected_level = 4
	$Level4Popup/LevelName.text = "The Obsidian Citadel"
	$Level4Popup/DifficultyTitle.text = "DIFFICULTY"
	$Level4Popup/DifficultyStars.text = "★★★★☆"
	$Level4Popup.show()
	$AnimationPlayer.play("level_4_popup_in")
	$QuitFade.show()

func _on_level_5_button_pressed() -> void:
	AudioManager.play_click()
	selected_level = 5
	$Level5Popup/LevelName.text = "Peak of the Eclipse"
	$Level5Popup/DifficultyTitle.text = "DIFFICULTY"
	$Level5Popup/DifficultyStars.text = "★★★★★"
	$Level5Popup.show()
	$AnimationPlayer.play("level_5_popular_in")
	$QuitFade.show()

func update_level_display() -> void:
	level_counter.text = "LEVEL %02d / %02d" % [current_level, total_levels]

	for i in range(total_levels):
		if i + 1 == current_level:
			dots[i].text = "●"
		else:
			dots[i].text = "○"

func _on_back_1_button_pressed() -> void:
	$Level1Popup.hide()
	$QuitFade.hide()

func _on_back_2_button_pressed() -> void:
	$Level2Popup.hide()
	$QuitFade.hide()

func _on_back_3_button_pressed() -> void:
	$Level3Popup.hide()
	$QuitFade.hide()

func _on_back_4_button_pressed() -> void:
	$Level4Popup.hide()
	$QuitFade.hide()

func _on_back_5_button_pressed() -> void:
	$Level5Popup.hide()
	$QuitFade.hide()


func _on_enter_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_enter_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
