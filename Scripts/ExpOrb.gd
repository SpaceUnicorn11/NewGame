extends RigidBody2D

@export var exp_amount = 10
var speed = 1000
var picked_up = false
signal give_exp
var type = str("exp")

func _process(delta):
	if picked_up:
		$NavigationAgent2D.target_position = get_node('/root/Main/Stage').player_position
		var velocity = Vector2.ZERO
		velocity = $NavigationAgent2D.get_next_path_position() - position
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		position += velocity * delta	
	if $NavigationAgent2D.is_target_reached():
		give_exp.emit(exp_amount)
		queue_free()
