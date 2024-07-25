extends RigidBody2D

@export var speed = 1000 # Projectile spee
@export var damage = 5 # Projectile damage
@export var direction : Vector2 # Projectile direction

# Called when the node enters the scene tree for the first time.
func _ready():
	
	linear_velocity = direction * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hit():
	linear_velocity = Vector2.ZERO
	queue_free() # despawn projectile after hit 
