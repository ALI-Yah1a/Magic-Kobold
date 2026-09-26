extends CharacterBody2D
class_name enemy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ground_ray: RayCast2D = $GroundRay
@onready var health_bar = $HealthBar

const FIRE_SCENE = preload("res://Scenes/dragon_fire.tscn")
var speed = 110
var chase_speed = 130
var attack_range = 120.0
var attack_cooldown = 1.2
var first_attack_delay = 0.4
var direction = 1
var max_hp = 2
var current_hp = 2
var is_alive = true
var is_hurt = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_chasing = false
var is_attacking = false
var is_preparing_attack = false
var can_attack = true 
var player_ref: Node2D = null

func _ready():
	health_bar.max_value = max_hp
	health_bar.value = current_hp

func _physics_process(delta):
	if not is_alive:
		return

	if not is_on_floor():
		velocity.y += gravity * delta

	if is_hurt or is_attacking:
		velocity.x = 0
		move_and_slide()
		return

	if is_chasing and is_instance_valid(player_ref):
		var enemy_visual_center = Vector2(global_position.x + animated_sprite_2d.position.x, global_position.y)
		var distance_to_player = enemy_visual_center.distance_to(player_ref.global_position)
		var dir_to_player = sign(player_ref.global_position.x - global_position.x)
		
		if dir_to_player != 0:
			direction = dir_to_player

		if distance_to_player <= attack_range:
			velocity.x = 0
			if can_attack and not is_preparing_attack:
				trigger_attack_sequence()
		else:
			if not ground_ray.is_colliding() and is_on_floor():
				velocity.x = 0
			elif is_on_wall():
				velocity.x = 0
			else:
				velocity.x = chase_speed * direction
	else:
		if is_on_wall():
			direction *= -1
		if not ground_ray.is_colliding() and is_on_floor():
			direction *= -1
		velocity.x = speed * direction
		
	move_and_slide()
	
	if not is_attacking and not is_hurt and not is_preparing_attack:
		if velocity.x != 0:
			animated_sprite_2d.play("walk")
			if direction > 0:
				animated_sprite_2d.flip_h = false
				animated_sprite_2d.position.x = 0 
				$DetectionArea.scale.x = 1
				ground_ray.position.x = abs(ground_ray.position.x) 
			else:
				animated_sprite_2d.flip_h = true
				animated_sprite_2d.position.x = 18
				$DetectionArea.scale.x = -1
				ground_ray.position.x = -abs(ground_ray.position.x) 
		else:
			animated_sprite_2d.play("idle")

func trigger_attack_sequence():
	is_preparing_attack = true
	animated_sprite_2d.play("idle")
	await get_tree().create_timer(first_attack_delay).timeout
	
	if is_alive and not is_hurt and is_instance_valid(player_ref):
		var enemy_visual_center = Vector2(global_position.x + animated_sprite_2d.position.x, global_position.y)
		var current_dist = enemy_visual_center.distance_to(player_ref.global_position)
		if current_dist <= attack_range:
			start_attack()
			
	is_preparing_attack = false

func start_attack():
	is_attacking = true
	can_attack = false 
	velocity.x = 0
	
	if animated_sprite_2d.sprite_frames.has_animation("attack"):
		animated_sprite_2d.play("attack")
		
	await get_tree().create_timer(0.4).timeout 
	
	if is_alive:
		breathe_fire()
	await get_tree().create_timer(0.3).timeout 
	is_attacking = false
	animated_sprite_2d.play("idle") 
	
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
func breathe_fire():
	var fire = FIRE_SCENE.instantiate()
	var is_facing_left = animated_sprite_2d.flip_h
	
	var spawn_offset_x = -30 if is_facing_left else 30
	fire.global_position = global_position + Vector2(spawn_offset_x, -10) 
	
	if is_facing_left:
		fire.scale.x = -1
		fire.direction = Vector2(-1, 1) 
	else:
		fire.scale.x = 1
		fire.direction = Vector2(1, 1) 
		
	get_tree().current_scene.add_child(fire)
func take_damage(amount):
	if not is_alive or is_hurt:
		return
		
	is_hurt = true
	current_hp -= amount
	health_bar.value = current_hp
	
	if is_attacking or is_preparing_attack:
		is_attacking = false
		is_preparing_attack = false
	
	if current_hp > 0:
		if animated_sprite_2d.sprite_frames.has_animation("hurt"):
			animated_sprite_2d.play("hurt")
		await get_tree().create_timer(0.4).timeout
		is_hurt = false
	else:
		die()

func die():
	if not is_alive:
		return
	is_alive = false
	velocity = Vector2.ZERO
	
	if animated_sprite_2d.sprite_frames.has_animation("death"):
		animated_sprite_2d.play("death")
		
	collision_shape_2d.set_deferred("disabled", true)
	await get_tree().create_timer(0.5).timeout
	
	var ui = get_tree().get_root().find_child("LevelUI", true, false)
	if ui and ui.has_method("add_monster_kill"):
		ui.add_monster_kill(1)
		
	queue_free()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_ref = body
		is_chasing = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player_ref:
		player_ref = null
		is_chasing = false
