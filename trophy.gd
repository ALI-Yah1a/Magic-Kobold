extends Area2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# Note: If your Autoload in Project Settings is lowercase 'global', 
		# make sure to change the capital Gs to lowercase gs below!
		if Global.current_level < Global.total_levels:
			Global.current_level += 1
			
		get_tree().call_group("UI", "trophy_collected")
		collect()

func collect() -> void:
	queue_free()
