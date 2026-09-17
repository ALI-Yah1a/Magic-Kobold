extends CanvasLayer
@onready var health_bar: TextureProgressBar = $HUD/PlayerStats/VitalsAndStats/HealthBar
@onready var dash_bar: TextureProgressBar = $HUD/PlayerStats/VitalsAndStats/DashBar
@onready var coins_label: Label = $HUD/PlayerStats/VitalsAndStats/CoinsTracker/CoinsLabel
@onready var monsters_label: Label = $HUD/PlayerStats/VitalsAndStats/MonstersTracker/MonstersLabel

@export var player: Player 
@export var required_coins: int = 50
@export var required_monsters: int = 10

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
		print("Level Complete!")
