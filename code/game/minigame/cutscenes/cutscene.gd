extends Minigame

@export var dialoge: DialogueResource
@onready var player: Planet = $Player
@onready var enemy: Planet = $Enemy



func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func enter(data: MinigameData):
	if data.c_dialoge_res == null:
		printerr("[Cutscene]: Cutscene Entered but dialogue not found!")
		emit_signal("minigame_ended")
		return
	dialoge = data.c_dialoge_res
	if data.c_enemy_res == null:
		enemy.hide()
	else:
		enemy.show()
		enemy.planet_resource = data.c_enemy_res
	DialogueManager.show_dialogue_balloon(dialoge)

func _on_dialogue_ended(_resource):
	emit_signal("minigame_ended")
