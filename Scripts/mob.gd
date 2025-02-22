extends RigidBody2D

@export var speed = 50 # How fast the mob will move (pixels/sec).
@export var health = 8 # How much health the mob has
@export var damage = 0 # How much damage the mob deals
@export var exp_orb_scene: PackedScene
var can_move = true # if mob can move
var type = str("mob")

signal hit # Emits when mob takes damage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$NavigationAgent2D.target_position = get_parent().player_position
	var velocity = Vector2.ZERO
	velocity = $NavigationAgent2D.get_next_path_position() - position
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		if position.x - $NavigationAgent2D.target_position.x < 0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play('move')
		else:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play('move')
	else:
		$AnimatedSprite2D.play('default')
		
	if can_move:	
		position += velocity * delta

func _on_body_entered(body):
	body.hit()
	health -= body.damage
	hit.emit(health)
	# HIt animation 
	$AnimatedSprite2D.hide()
	await get_tree().create_timer(0.1).timeout 
	$AnimatedSprite2D.show()
	# death
	if health <= 0:
		var exp_orb = exp_orb_scene.instantiate()
		exp_orb.position = position
		get_node('/root/Main/Stage').add_child(exp_orb)
		queue_free()
