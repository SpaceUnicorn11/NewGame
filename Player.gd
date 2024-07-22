extends Area2D

@export var speed = 100 # How fast the player will move (pixels/sec).
@export var health = 50 # Players health
signal hit
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta


func _on_body_entered(body):
	hit.emit()
	health -= 1
	# iframes or death
	$CollisionShape2D.set_deferred("disabled", true)
	if health <= 0:
		death()
	else: 	
		await get_tree().create_timer(0.5).timeout 
		$CollisionShape2D.set_deferred("enabled", true)
	
		
func death():
	pass		
