extends CanvasLayer
@onready var health_bar: TextureProgressBar = $HUD/PlayerStats/VitalsAndStats/HealthBar
@onready var dash_bar: TextureProgressBar = $HUD/PlayerStats/VitalsAndStats/DashBar
@onready var coins_label: Label = $HUD/PlayerStats/VitalsAndStats/CoinsTracker/CoinsLabel
@onready var monsters_label: Label = $HUD/PlayerStats/VitalsAndStats/MonstersTracker/MonstersLabel
@onready var pause_menu: Control = $PauseMenu
@onready var level_complete: Control = $LevelComplete
@export var player: Player 
@export var required_coins: int = 50
@export var required_monsters: int = 10
@export_file("*.tscn") var next_level_path: String
var current_coins: int = 0
var current_monsters: int = 0

func _ready():
	if player:
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
		player.health_changed.connect(update_health)
		
		dash_bar.max_value = 100
		dash_bar.value = dash_bar.max_value
		player.dash_started.connect(animate_dash_bar)
	pause_menu.visible = false
	update_coins_ui()
	update_monsters_ui()
	

func update_health(new_health):
	health_bar.value = new_health

func animate_dash_bar(cooldown_duration):
	dash_bar.value = 0
	var tween = create_tween()
	tween.tween_property(dash_bar, "value", dash_bar.max_value, cooldown_duration)

func add_coin(amount: int = 1):
	current_coins += amount
	update_coins_ui()
	check_level_completion()

func add_monster_kill(amount: int = 1):
	current_monsters += amount
	update_monsters_ui()
	check_level_completion()

func update_coins_ui():
	coins_label.text = str(current_coins) + " / " + str(required_coins)

func update_monsters_ui():
	monsters_label.text = str(current_monsters) + " / " + str(required_monsters)

func check_level_completion():
	if current_coins >= required_coins and current_monsters >= required_monsters: 
		level_complete.visible = true
		get_tree().paused = true
func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
	# cheat button
	if event is InputEventKey and event.pressed and event.keycode == KEY_T:
		level_complete.visible = true
		get_tree().paused = true
func toggle_pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	pause_menu.visible = new_pause_state
	
	
func _on_resume_button_pressed():
	toggle_pause()

func _on_main_menu_button_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	if next_level_path != "":
		get_tree().change_scene_to_file(next_level_path)
