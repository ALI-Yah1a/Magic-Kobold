extends Control


@onready var direction_label = $DirectionLabel
@onready var jump_label = $JumpLabel
@onready var attack_label = $AttackLabel
@onready var dash_label = $DashLabel
@onready var pause_label = $PauseLabel



func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:

		if event.keycode == KEY_A:
			direction_label.text = "LEFT"

		elif event.keycode == KEY_D:
			direction_label.text = "RIGHT"

		elif event.keycode == KEY_W:
			jump_label.text = "JUMP"

		elif event.keycode == KEY_SPACE:
			jump_label.text = "JUMP ALSO"

		elif event.keycode == KEY_E:
			attack_label.text = "ATTACK"

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			attack_label.text = "ATTACK ALSO"

		elif event.keycode == KEY_SHIFT:
			attack_label.text = "DASH"

		elif event.keycode == KEY_ESCAPE:
			attack_label.text = "PAUSE"

func _on_a_button_pressed() -> void:
	direction_label.text = "LEFT"


func _on_d_button_pressed() -> void:
	direction_label.text = "RIGHT"


func _on_space_button_pressed() -> void:
	jump_label.text = "JUMP ALSO"


func _on_w_button_pressed() -> void:
	jump_label.text = "JUMP"


func _on_e_button_pressed() -> void:
	attack_label.text = "ATTACK"


func _on_l_m_b_button_pressed() -> void:
	attack_label.text = "ATTACK ALSO"


func _on_shift_button_pressed() -> void:
	dash_label.text = "DASH"


func _on_escape_button_pressed() -> void:
	pause_label.text = "PAUSE"



func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
