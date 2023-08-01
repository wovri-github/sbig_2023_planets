extends Fighter



func _init():
	fighter = Fighter.TYPE.ENEMY
	

func start_turn():
	enemy.get_damage(damage)
