extends Area2D

var speed = 200 
var damage = 10
var direction = Vector2(1, 0) 

func _ready():
	await get_tree().create_timer(0.4).timeout
	queue_free()
func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()
	elif body is TileMap or body is StaticBody2D: 
		queue_free()
