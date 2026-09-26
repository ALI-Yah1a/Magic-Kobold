extends Area2D

var speed = 200
var direction = 1
var damage = 10

func _ready():
	await get_tree().create_timer(0.8).timeout
	queue_free()
func _physics_process(delta):

	position.x += speed * direction * delta
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()
	elif body is TileMap: 
		queue_free()
