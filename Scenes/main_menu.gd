extends Control



func _ready() -> void:
	pass # Replace with function body.


 
func _process(delta: float) -> void:
	pass


func _on_newgamebutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/levels.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
