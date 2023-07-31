@tool
extends Minigame

enum TURN{PLAYER, ENEMY}
var current_turn: Fighter
@onready var celestials = {
	TURN.PLAYER: $Player,
	TURN.ENEMY: $Enemy,
}

#func _ready():
#	if Engine.is_editor_hint():
#		return
#	var data = MinigameData.new()
#	data.f_enemy_res = load("res://resources/planet/planet1.tres")
#	enter(data)



func enter(data: MinigameData):
	$Enemy.planet_res = data.f_enemy_res
	$Player.planet_res = $Player/Planet.planet_resource
	current_turn = celestials[TURN.PLAYER]
	current_turn._start_turn()

func swap_turn():
	current_turn._end_turn()
	if celestials[TURN.PLAYER] == current_turn:
		current_turn = celestials[TURN.ENEMY]
	else:
		current_turn = celestials[TURN.PLAYER]
		
	current_turn._start_turn()


func _on_player_turn_ended():
	swap_turn()

func _on_enemy_turn_ended():
	swap_turn()


func _on_player_defeated():
	current_turn._end_turn()
	emit_signal("minigame_ended", false)

func _on_enemy_defeated():
	current_turn._end_turn()
	emit_signal("minigame_ended", true)
