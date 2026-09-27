extends Control
@onready var animation_player = $AnimationPlayer



func _ready() -> void:
	pass # Replace with function body.


 
func _process(delta: float) -> void:
	pass


func _on_newgamebutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels.tscn")
	Transition.change_scene("res://Scenes/levels.tscn")
	AudioManager.play_click()
func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")
	Transition.change_scene("res://Scenes/options.tscn")
	AudioManager.play_click()
func _on_quit_button_pressed() -> void:
	$QuitPopup.show()
	AudioManager.play_click()
	$QuitFade.show()
	$AnimationPlayer.play("QuitPopup")
	

func _on_how_to_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")
	Transition.change_scene("res://Scenes/how_to_play.tscn")
	AudioManager.play_click()

func _on_no_button_pressed() -> void:
	$QuitPopup.hide()
	AudioManager.play_click()
	$QuitFade.hide()

func _on_yes_button_pressed() -> void:
	get_tree().quit()
	AudioManager.play_click()
