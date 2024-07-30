extends Button

var action :String

func press():
	match action:
		"health":
			get_node('/root/Main/Stage/Player').gain_health(20)
		"damage":
			get_node('/root/Main/Stage/Player/Weapon').damage += 2
		"movespeed":
			get_node('/root/Main/Stage/Player').speed += 30
		"weapon_cooldown":
			get_node('/root/Main/Stage/Player/Weapon/WeaponCooldown').wait_time -= 0.1
		"number_of_shots":
			get_node('/root/Main/Stage/Player/Weapon').number_of_shots += 1
		"pickup_area":
			get_node('/root/Main/Stage/Player/PickupArea/CollisionShape2D').scale += Vector2(0.2, 0.2)
