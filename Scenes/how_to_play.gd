extends Control


@onready var direction_label = $DirectionLabel


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:

		if event.keycode == KEY_A:
			direction_label.text = "LEFT"

		elif event.keycode == KEY_D:
			direction_label.text = "RIGHT"


func _on_a_button_pressed() -> void:
	direction_label.text = "LEFT"


func _on_d_button_pressed() -> void:
	direction_label.text = "RIGHT"
