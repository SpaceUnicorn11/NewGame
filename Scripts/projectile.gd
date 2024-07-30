extends RigidBody2D

@export var speed = 1000 # Projectile speed
var damage = 0 # Projectile damage
@export var direction : Vector2 # Projectile direction

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = get_node('/root/Main/Stage/Player/Weapon').damage
	linear_velocity = direction * speed


func hit():
	linear_velocity = Vector2.ZERO
	queue_free() # despawn projectile after hit 
