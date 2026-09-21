extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

const SPEED = 170.0
const JUMP_VELOCITY = -450.0
const DASH_SPEED = 250.0
const DASH_COOLDOWN = 2

var is_attacking = false
var can_attack = true
var is_hurt = false
var is_dash_attacking = false
var is_dashing = false 
var can_dash = true    

var max_health = 100
var current_health = 100
signal health_changed(new_health) 
signal dash_started(duration)

func _ready():
	current_health = max_health
	$Hitbox.monitoring = false
func _input(event):
	if is_hurt:
		return
	if event.is_action_pressed("jump") and is_on_floor():
		is_dashing = false
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")
	if event.is_action_pressed("dash") and can_dash and not is_dashing and not is_attacking:
		start_dash()

	if can_attack and not is_hurt:
		if event.is_action_pressed("attack"):
			if is_dashing:
				is_dashing = false 
				dash_attack()
			else:
				attack()

func _physics_process(delta):
	if is_hurt or (is_attacking and not is_dash_attacking):
		velocity.x = 0
		if not is_on_floor():
			velocity += get_gravity() * delta
		move_and_slide()
		return

	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction = Input.get_axis("run_left", "run_right")
	if is_dash_attacking:
		var facing_dir = -1 if animated_sprite_2d.flip_h else 1
		velocity.x = facing_dir * DASH_SPEED
	elif is_dashing:
		var facing_dir = -1 if animated_sprite_2d.flip_h else 1
		velocity.x = facing_dir * DASH_SPEED
	else:
		if direction != 0:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if not is_dash_attacking and not is_dashing:
		update_facing_direction(direction)
		update_animations(direction)

func update_facing_direction(direction: float):
	if direction == 0:
		return 
		
	var is_facing_left = direction < 0
	animated_sprite_2d.flip_h = is_facing_left
	
	if is_facing_left:
		animated_sprite_2d.position.x = -9 
		$Hitbox.position.x = -25.0 
	else:
		animated_sprite_2d.position.x = 0 
		$Hitbox.position.x = 25.0
func update_animations(direction: float):
	if not is_on_floor():
		if velocity.y < 0.0:
			animated_sprite_2d.play("jump")
		elif velocity.y > 0.0:
			animated_sprite_2d.play("fall")
	elif direction != 0:
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")

func start_dash():
	is_dashing = true
	can_dash = false
	animated_sprite_2d.play("dash")
	dash_started.emit(DASH_COOLDOWN)
	get_tree().create_timer(DASH_COOLDOWN).timeout.connect(func(): can_dash = true)

func attack():
	is_attacking = true
	can_attack = false
	animated_sprite_2d.play("attack")
	$Hitbox.monitoring = true

func dash_attack():
	is_attacking = true
	is_dash_attacking = true
	can_attack = false
	animated_sprite_2d.play("dash-attack")
	$Hitbox.monitoring = true

func take_damage(amount):
	if is_hurt:
		return
	is_dashing = false
	current_health -= amount
	current_health = clamp(current_health, 0, max_health) 
	health_changed.emit(current_health)
	print("Player took damage! Current HP: ", current_health)
	if is_attacking:
		is_attacking = false
		can_attack = true
		$Hitbox.set_deferred("monitoring", false)
	
	if current_health > 0:
		is_hurt = true
		animated_sprite_2d.play("hurt")
		await animated_sprite_2d.animation_finished
		is_hurt = false
	else:
		die()

func die():
	set_physics_process(false)
	animated_sprite_2d.play("dead")
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "attack" or animated_sprite_2d.animation == "dash-attack":
		is_attacking = false
		is_dash_attacking = false
		can_attack = true
		$Hitbox.monitoring = false
	if animated_sprite_2d.animation == "dash":
		is_dashing = false


func _on_hitbox_body_entered(body: Node2D) -> void:
	if not is_attacking:
		return
	if body is Enemy and body.has_method("take_damage"):
		body.take_damage(1)
