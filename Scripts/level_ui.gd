extends CanvasLayer

@onready var health_bar: TextureProgressBar = $HUD/PlayerStats/VitalsAndStats/HealthBar
@onready var dash_bar: TextureProgressBar = $HUD/PlayerStats/VitalsAndStats/DashBar


@export var player: Player 

func _ready():
	if player:
		health_bar.max_value = player.max_health
		health_bar.value = player.current_health
		player.health_changed.connect(update_health)
		dash_bar.max_value = 100
		dash_bar.value = dash_bar.max_value
		player.dash_started.connect(animate_dash_bar)
func update_health(new_health):
	health_bar.value = new_health
func animate_dash_bar(cooldown_duration):
	dash_bar.value = 0
	var tween = create_tween()
	tween.tween_property(dash_bar, "value", dash_bar.max_value, cooldown_duration)
