extends Node

@export var mob_scene: PackedScene
var player_position :Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn(5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_position = $Player.position


func _on_spawn_timer_timeout():
	spawn(5)
	
# Spawn "amount" mobs	
func spawn(amount :int):
	var modifier = [-1, 1]
	for i in amount:
		var mob = mob_scene.instantiate()
		mob.position.x = $Player.position.x + randi_range(0, 700) * modifier.pick_random()
		if mob.position.x < $Player.position.x + 500:
			mob.position.y = $Player.position.y + randi_range(500, 700) * modifier.pick_random()
		else:
			mob.position.y = $Player.position.y + randi_range(0, 700) * modifier.pick_random()
		add_child(mob)
	


func _on_player_dead():
	$SpawnTimer.stop()
