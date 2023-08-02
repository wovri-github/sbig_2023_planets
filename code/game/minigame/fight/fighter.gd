extends Node2D
class_name Fighter

signal defeated()
signal turn_ended()

enum TYPE{PLAYER, ENEMY}

@export var fight_manager: Node
@export var enemy: Fighter
var planet_res: PlanetResource:
	set(new_planet):
		planet_res = new_planet
		$Planet.planet_resource = planet_res
		max_health = planet_res.health
		damage = planet_res.damage
		current_health = max_health
		fight_manager.set_hp(fighter, current_health, max_health)
		flair_up = 0
		setup_complete()
		if planet_res.dialogue_name == "Planet 1":
			max_flair_up = 2
		else:
			max_flair_up = 3
var fighter: TYPE
var max_health: int
var current_health: int
var flair_up: int = 0
var max_flair_up: int = 3
var damage: int





func _start_turn():
	await get_tree().create_timer(0.2).timeout
	if is_defeated():
		return
	start_turn()

func start_turn():
	pass
func _end_turn():
	end_turn()
func end_turn():
	pass

func setup_complete():
	pass

func get_damage(_damage: int):
	current_health = max(0, current_health - _damage)
	fight_manager.set_hp(fighter, current_health, max_health)
	
	
func attack():
	enemy.get_damage(damage)
	reset_flair_up()

func reset_flair_up():
	pass

func is_defeated() -> bool:
	if current_health == 0:
		current_health = 0
		emit_signal("defeated")
		return true
	return false
	

func turn_complete():
	emit_signal("turn_ended")
