extends Node

@export var stage_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$EndStageMenu.hide()
	$PauseMenu.hide()
	$LevelUpMenu.hide()
	$VictoryMenu.hide()
	$MainMenu.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("pause_menu") && $PauseMenu.visible == false:
		$PauseMenu.show()
		pause_game()
	


func _on_start_game_button_pressed():
	var stage = stage_scene.instantiate()
	add_child(stage)
	$MainMenu.hide()
	var player = get_node('/root/Main/Stage/Player')
	player.dead.connect(_on_player_death)
	player.level_up.connect(_on_player_level_up)
	var game_timer = get_node('/root/Main/Stage/Hud/GameTime')
	game_timer.end_game.connect(_on_end_game_timer)

func pause_game():
	get_tree().paused = true
	
	
func resume_game():
	get_tree().paused = false
	

func _on_resume_button_pressed():
	$PauseMenu.hide()
	resume_game()


func _on_main_menu_button_pressed():
	get_tree().paused = false
	if get_node('/root/Main/Stage') != null:
		get_node('/root/Main/Stage').queue_free()
	$MainMenu.show()
	$PauseMenu.hide()
	$EndStageMenu.hide()
	$VictoryMenu.hide()
	
func _on_player_death():
	$EndStageMenu.show()
	get_node('/root/Main/Stage').queue_free()
	
func _on_player_level_up(gained_exp):
	pause_game()
	$LevelUpMenu.show()
	var cards = randomize_levelup_cards()
	match cards[0]:
		"health":
			$LevelUpMenu/Left.text = "Get +20 health"
			$LevelUpMenu/Left.action = "health"
		"damage":
			$LevelUpMenu/Left.text = "Get +2 damage"
			$LevelUpMenu/Left.action = "damage"
		"movespeed":
			$LevelUpMenu/Left.text = "Get +30 movement speed"
			$LevelUpMenu/Left.action = "movespeed"
		"weapon_cooldown":
			$LevelUpMenu/Left.text = "Get 10% reload speed"
			$LevelUpMenu/Left.action = "weapon_cooldown"
		"number_of_shots":
			$LevelUpMenu/Left.text = "Get +1 shot per cooldown"
			$LevelUpMenu/Left.action = "number_of_shots"
		"pickup_area":
			$LevelUpMenu/Left.text = "Get 20% pickup range"
			$LevelUpMenu/Left.action = "pickup_area"
	match cards[1]:
		"health":
			$LevelUpMenu/Middle.text = "Get +20 health"
			$LevelUpMenu/Middle.action = "health"
		"damage":
			$LevelUpMenu/Middle.text = "Get +2 damage"
			$LevelUpMenu/Middle.action = "damage"
		"movespeed":
			$LevelUpMenu/Middle.text = "Get +30 movement speed"
			$LevelUpMenu/Middle.action = "movespeed"
		"weapon_cooldown":
			$LevelUpMenu/Middle.text = "Get 10% reload speed"
			$LevelUpMenu/Middle.action = "weapon_cooldown"
		"number_of_shots":
			$LevelUpMenu/Middle.text = "Get +1 shot per cooldown"
			$LevelUpMenu/Middle.action = "number_of_shots"
		"pickup_area":
			$LevelUpMenu/Middle.text = "Get 20% pickup range"
			$LevelUpMenu/Middle.action = "pickup_area"
	match cards[2]:
		"health":
			$LevelUpMenu/Right.text = "Get +20 health"
			$LevelUpMenu/Right.action = "health"
		"damage":
			$LevelUpMenu/Right.text = "Get +2 damage"
			$LevelUpMenu/Right.action = "damage"
		"movespeed":
			$LevelUpMenu/Right.text = "Get +30 movement speed"
			$LevelUpMenu/Right.action = "movespeed"
		"weapon_cooldown":
			$LevelUpMenu/Right.text = "Get 10% reload speed"
			$LevelUpMenu/Right.action = "weapon_cooldown"
		"number_of_shots":
			$LevelUpMenu/Right.text = "Get +1 shot per cooldown"
			$LevelUpMenu/Right.action = "number_of_shots"
		"pickup_area":
			$LevelUpMenu/Right.text = "Get 20% pickup range"
			$LevelUpMenu/Right.action = "pickup_area"

func _on_button_pressed():
	resume_game()
	$LevelUpMenu.hide()
	

func _on_left_levelup_pressed():
	$LevelUpMenu/Left.press()
	resume_game()
	$LevelUpMenu.hide()
	

func _on_middle_levelup_pressed():
	$LevelUpMenu/Middle.press()
	resume_game()
	$LevelUpMenu.hide()


func _on_right_levelup_pressed():
	$LevelUpMenu/Right.press()
	resume_game()
	$LevelUpMenu.hide()

func randomize_levelup_cards():
	var buffs_list :Array[String]
	var chosen_buffs :Array
	var choices = 0
	buffs_list = ["health", "damage", "movespeed", "weapon_cooldown", "number_of_shots", "pickup_area"]
	while choices < 3:
		var index = randi_range(0, buffs_list.size() - 1)
		chosen_buffs.append(buffs_list[index])
		buffs_list.remove_at(index)
		choices += 1
	return chosen_buffs

func _on_end_game_timer():
	$VictoryMenu.show()
	get_node('/root/Main/Stage').queue_free()
