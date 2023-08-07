extends CanvasLayer

signal player_died()
signal player_went_to_next_plot()

@export var plot_minigames: Array[MinigameData]
var current_minigame: Minigame
var plot_tracker: int = Storage.get_value("game", "plot_tracker", 0)
var music_correlation = {
	Minigame.TYPE.CUTSCENE: Music.TYPE.CUTSCENE,
	Minigame.TYPE.TRAVEL: Music.TYPE.TRAVEL,
	Minigame.TYPE.FIGHT: Music.TYPE.FIGHT,
}
@onready var minigames = {
	Minigame.TYPE.CUTSCENE: $Cutscene,
	Minigame.TYPE.TRAVEL: $Travel,
	Minigame.TYPE.FIGHT: $Fight,
}



func _ready():
	current_minigame = minigames[plot_minigames[plot_tracker].minigame_type]
	Music.play_music = music_correlation[plot_minigames[plot_tracker].minigame_type]
	current_minigame._enter(plot_minigames[plot_tracker])

func change_current_game(change_to: Minigame.TYPE, data: MinigameData = null):
	make_transition(change_to)
	current_minigame._exit()
	current_minigame = minigames[change_to]
	current_minigame._enter(data)


func next_game_plot():
	plot_tracker += 1
	Storage.set_value("game", "plot_tracker", plot_tracker)
	if plot_tracker >= plot_minigames.size():
		get_tree().change_scene_to_file("res://code/ui/menu/win_menu.tscn")
		return
	var minigame_data = plot_minigames[plot_tracker]
	change_current_game(minigame_data.minigame_type, minigame_data)

func make_transition(change_to: Minigame.TYPE):
	if plot_tracker == 10:
		Music.play_music = Music.TYPE.BOSS_FIGHT
	else:
		Music.play_music = music_correlation[change_to]
	if change_to == Minigame.TYPE.CUTSCENE or change_to == Minigame.TYPE.FIGHT:
		$Background.is_moving = false
	else:
		$Background.is_moving = true

func _on_minigame_ended(is_success):
	if is_success:
		next_game_plot()
	else:
		$UI._on_player_died()
		await $UI/DiedMenu.visibility_changed
		var minigame_data = plot_minigames[plot_tracker]
		change_current_game(minigame_data.minigame_type, minigame_data)


func _on_pause_menu_restart_clicked():
	var minigame_data = plot_minigames[plot_tracker]
	change_current_game(minigame_data.minigame_type, minigame_data)
