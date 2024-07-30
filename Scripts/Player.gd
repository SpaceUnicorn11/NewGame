extends Area2D

@export var speed = 200 # How fast the player will move (pixels/sec).
@export var max_health = 50 # Players max health
var health = 50 # Players current health
var can_move = true # If player can move
var current_exp :int = 0 # Player current exp
var next_level_exp = 50 # How much exp to next level

signal hit # Emits when player takes damage
signal healed # Emits when player gains health
signal dead # Emits when dead
signal exp_gained # Emits when gained exp
signal level_up # Emits when level up

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	var player_facing_direction = Vector2(0, 0) # Player facing direction
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		player_facing_direction.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		player_facing_direction.x = -1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		player_facing_direction.y = 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		player_facing_direction.y = -1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if can_move:	
		position += velocity * delta
		position = position.clamp(Vector2(50, 70), Vector2(3790, 2150))
		if player_facing_direction.length() > 0:
			$Weapon.direction = player_facing_direction.normalized()


func _on_body_entered(body):
	if body.type == str("exp"):
		gain_exp(body.exp_amount)
		body.queue_free()
	if body.type == str("mob"):
		# death
		if health - body.damage >= 0:
			health -= body.damage
			hit.emit(health)
		else: 	
			health = 0
			hit.emit(health)
			death()
		# HIt animation 
		$AnimatedSprite2D.play(("hit"))
		await get_tree().create_timer(0.1).timeout 
		$AnimatedSprite2D.play(("default"))
		# Iframes
		$CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(0.3).timeout
		$CollisionShape2D.set_deferred("disabled", false)
		
	
		
func death():
	dead.emit()
	can_move = false

func gain_health(gained_health):
	max_health += gained_health
	health += gained_health
	healed.emit(health, max_health)

func gain_exp(gained_exp :int):
	if current_exp < next_level_exp:
		current_exp += gained_exp
		exp_gained.emit(current_exp)
	if current_exp >= next_level_exp:
		current_exp	-= next_level_exp
		next_level_exp += 50
		exp_gained.emit(current_exp)
		level_up.emit(next_level_exp)


func _on_pickup_area_body_entered(body):
	gain_exp(body.exp_amount)
	body.queue_free()
