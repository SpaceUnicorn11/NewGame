extends Node

@export var mob_scene: PackedScene
var player_position :Vector2
var difficulty_modifier = 1
var timer_counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hud.show()
	spawn(5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_position = $Player.position


func _on_spawn_timer_timeout():
	timer_counter += 1
	if timer_counter == 4:
		timer_counter = 0
		difficulty_modifier += 1
		spawn(5 * difficulty_modifier)
	else: spawn(5 * difficulty_modifier)


# Spawn "amount" mobs	
func spawn(amount :int):
	var modifier = [-1, 1]
	for i in amount:
		var mob = mob_scene.instantiate()
		mob.position.x = $Player.position.x + randi_range(0, 1000) * modifier.pick_random()
		if mob.position.x < $Player.position.x + 500:
			mob.position.y = $Player.position.y + randi_range(500, 1000) * modifier.pick_random()
		else:
			mob.position.y = $Player.position.y + randi_range(0, 1000) * modifier.pick_random()
		mob.health += difficulty_modifier * 2
		mob.damage = difficulty_modifier
		add_child(mob)



func _on_player_dead():
	$SpawnTimer.stop()
