extends CanvasLayer

@export var debug = true
@export var plot_minigames: Array[MinigameData]
var current_minigame: Minigame
var plot_tracker: int = 0
@onready var minigames = {
	Minigame.TYPE.CUTSCENE: $Cutscene,
	Minigame.TYPE.TRAVEL: $Travel,
	Minigame.TYPE.FIGHT: $Fight,
}



func _ready():
	if debug == false:
		$Debug.queue_free()
	current_minigame = minigames[Minigame.TYPE.CUTSCENE]
	current_minigame._enter(plot_minigames[0])

func change_current_game(change_to: Minigame.TYPE, data: MinigameData = null):
	if minigames[change_to] == current_minigame:
		return
	make_transition(change_to)
	current_minigame._exit()
	current_minigame = minigames[change_to]
	current_minigame._enter(data)


func next_game_plot():
	plot_tracker += 1
	if plot_tracker >= plot_minigames.size():
		print("You win")
		await get_tree().create_timer(0.25).timeout
		get_tree().quit()
		return
	var minigame_data = plot_minigames[plot_tracker]
	change_current_game(minigame_data.minigame_type, minigame_data)

func make_transition(change_to: Minigame.TYPE):
	var tween = get_tree().create_tween()
	if change_to == Minigame.TYPE.CUTSCENE or change_to == Minigame.TYPE.FIGHT:
		tween.tween_property(self, "offset", Vector2(0, -30), 1.0)
	else:
		tween.tween_property(self, "offset", Vector2(0, 0), 1.0)
	await tween.finished


func _on_minigame_ended(is_success):
	if is_success:
		next_game_plot()
	else:
		var minigame_data = plot_minigames[plot_tracker]
		change_current_game(minigame_data.minigame_type, minigame_data)
