extends Minigame

signal turn_fight_ended()

enum TURN{PLAYER, ENEMY}
var current_turn: Fighter
@onready var celestials = {
	TURN.PLAYER: $Player,
	TURN.ENEMY: $Enemy,
}

func _ready():
	enter()

func enter():
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
	print("Playyer defeated!")

func _on_enemy_defeated():
	current_turn._end_turn()
	print("Enemy defeated!")
