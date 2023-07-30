extends Node
class_name Fighter

signal defeated()
signal turn_ended()

enum TYPE{PLAYER, ENEMY}

@export var fight_manager: Node
@export var enemy: Fighter
@export var own_stats: FightStatistics
var fighter: TYPE
@onready var max_health: int = own_stats.health
@onready var damage: int = own_stats.damage
@onready var current_health: int = max_health



func _ready():
	await get_tree().process_frame
	fight_manager.set_hp(fighter, current_health, max_health)

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
