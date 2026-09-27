extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_returnbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn") 
Transition.change_scene("res://Scenes/main_menu.tscn")
AudioManager.play_click()

func _on_level_1_button_pressed() -> void:
	Transition.change_scene("res://Scenes/trials scene.tscn")
	AudioManager.play_click()


func _on_level_2_button_pressed() -> void:
	AudioManager.play_click()


func _on_level_3_button_pressed() -> void:
	AudioManager.play_click()


func _on_level_4_button_pressed() -> void:
	AudioManager.play_click()

func _on_level_5_button_pressed() -> void:
	AudioManager.play_click()
