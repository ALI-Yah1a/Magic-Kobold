extends Control


func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_return_to_main_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	Transition.change_scene("res://Scenes/main_menu.tscn")
