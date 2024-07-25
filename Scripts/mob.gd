extends RigidBody2D

@export var speed = 50 # How fast the mob will move (pixels/sec).
@export var health = 10 # How much health the mob has
@export var damage = 1 # How much damage the mob deals

signal hit # Emits when mob takes damage
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$NavigationAgent2D.target_position = get_parent().player_position
	var velocity = Vector2.ZERO
	velocity = $NavigationAgent2D.get_next_path_position() - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#$AnimatedSprite2D.play()
	#else:
		#$AnimatedSprite2D.stop()
		
	position += velocity * delta

func _on_body_entered(body):
	body.hit()
	health -= body.damage
	hit.emit(health)
	# HIt animation 
	$AnimatedSprite2D.play(("hit"))
	await get_tree().create_timer(0.1).timeout 
	$AnimatedSprite2D.play(("default"))
	# death
	if health <= 0:
		queue_free()
