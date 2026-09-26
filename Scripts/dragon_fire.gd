extends Area2D

var speed = 150
var damage = 10
var direction = Vector2(1, 1) 

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
	elif body is TileMap or body is StaticBody2D: 
		queue_free()
