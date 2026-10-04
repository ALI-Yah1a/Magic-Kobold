extends Control

@onready var animation_player = $AnimationPlayer


func change_scene(scene_path: String) -> void:

	get_tree().change_scene_to_file(scene_path)

	await get_tree().process_frame

	animation_player.play("fade_in")
