extends ProgressBar
var player
var current_exp 
var next_level_exp

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node('/root/Main/Stage/Player')
	next_level_exp = player.next_level_exp
	current_exp = player.current_exp
	player.exp_gained.connect(_on_exp_gained)
	player.level_up.connect(_on_player_level_up)
	max_value = next_level_exp
	value = current_exp


func _on_exp_gained(gained_exp):
	value = gained_exp

func _on_player_level_up(level_exp):
	max_value = level_exp
