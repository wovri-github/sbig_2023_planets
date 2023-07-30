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
var fighter: TYPE
var max_health: int
var damage: int
var current_health: int





func _start_turn():
	start_turn()
func start_turn():
	pass
func _end_turn():
	end_turn()
func end_turn():
	pass


func get_damage(_damage: int):
	current_health = max(0, current_health - _damage)
	fight_manager.set_hp(fighter, current_health, max_health)
	if current_health == 0:
		current_health = 0
		emit_signal("defeated")
		return
	emit_signal("turn_ended")
