extends Node2D
@export var projectile_scene: PackedScene
@export var number_of_shots = 1 # Number of shots per cooldown
var direction = Vector2(1, 0)
@export var damage = 5


func _on_weapon_cooldown_timeout():
	for i in range(number_of_shots):
		shoot()
		await get_tree().create_timer(0.1).timeout 

func shoot():
	var projectile = projectile_scene.instantiate()
	projectile.direction = direction
	add_child(projectile)
