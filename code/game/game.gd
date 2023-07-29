extends Node

@export var debug = true
var current_minigame: Minigame
@onready var minigames = {
	Minigame.ASTEROIDS: $AsteroidsGame,
	Minigame.TURN_FIGHT: $TurnFight
}



func _ready():
	if debug == false:
		$Debug.queue_free()
	current_minigame = minigames[Minigame.ASTEROIDS]
	current_minigame._enter()

func change_current_game(change_to: int):
	if minigames[change_to] == current_minigame:
		return
	current_minigame._exit()
	current_minigame = minigames[change_to]
	current_minigame._enter()



func _on_change_to_asteroids_pressed():
	change_current_game(Minigame.ASTEROIDS)

func _on_change_to_turn_fight_pressed():
	change_current_game(Minigame.TURN_FIGHT)
