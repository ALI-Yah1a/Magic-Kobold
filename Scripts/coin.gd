extends Area2D

@onready var pickup_sound = $PickupSound



func _on_body_entered(body):
 if body is Player:
  get_tree().call_group("UI", "add_coin")
  collect()
  
func collect():
 $CollisionShape2D.set_deferred("disabled", true)
 hide()
 pickup_sound.play()
 await pickup_sound.finished
 queue_free()
