extends Node2D
@export var projectile_scene: PackedScene
@export var fire_rate = 1 # Number of shots per cooldown
var direction = Vector2(1, 0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_weapon_cooldown_timeout():
	for i in range(fire_rate):
		shoot()
		await get_tree().create_timer(0.1).timeout 

func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.direction = direction
	add_child(projectile)
