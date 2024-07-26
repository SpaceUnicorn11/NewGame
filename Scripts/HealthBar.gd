extends ProgressBar
var player
var max_health
var current_health

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node('/root/Main/Stage/Player')
	max_health = player.max_health
	current_health = player.health
	player.hit.connect(_on_player_hit)
	player.healed.connect(_on_player_healed)
	
	max_value = max_health
	value = current_health
	$HealthValue.text = str(current_health, "/", max_health)

func _on_player_hit(health):
	current_health = health
	value = current_health
	$HealthValue.text = str(current_health, "/", max_health)

func _on_player_healed():
	max_health = player.max_health
	current_health = player.health
	value = current_health
	$HealthValue.text = str(current_health, "/", max_health)
