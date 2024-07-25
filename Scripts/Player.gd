extends Area2D

@export var speed = 100 # How fast the player will move (pixels/sec).
@export var health = 50 # Players health
var alive = true # Is palyer alive

signal hit # Emits when player takes damage
signal dead # Emits when dead
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
		
	if alive:	
		position += velocity * delta
		if player_facing_direction.length() > 0:
			$Weapon.direction = player_facing_direction.normalized()


func _on_body_entered(body):
	health -= body.damage
	hit.emit(health)
	# HIt animation 
	$AnimatedSprite2D.play(("hit"))
	await get_tree().create_timer(0.1).timeout 
	$AnimatedSprite2D.play(("default"))
	# Iframes
	$CollisionShape2D.set_deferred("disabled", true)
	await get_tree().create_timer(0.3).timeout
	$CollisionShape2D.set_deferred("disabled", false)
	# death
	if health <= 0:
		death()
	#else: 	
		
	
		
func death():
	alive = false
