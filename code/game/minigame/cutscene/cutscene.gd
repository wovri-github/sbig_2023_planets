@tool
extends Minigame

@export var dialoge: DialogueResource
@export var is_debug = true
@onready var player: Planet = $Player
@onready var enemy: Planet = $Enemy



func _ready():
	if Engine.is_editor_hint():
		return
	if is_debug:
		enter(load("res://resources/minigame_data/intro.tres"))
	else:
		self.process_mode = Node.PROCESS_MODE_DISABLED
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func enter(data: MinigameData):
	if data.c_dialoge_res == null:
		printerr("[Cutscene]: Cutscene Entered but dialogue not found!")
		emit_signal("minigame_ended", true)
		return
	dialoge = data.c_dialoge_res
	if data.c_enemy_res == null:
		enemy.hide()
	else:
		enemy.show()
		enemy.planet_resource = data.c_enemy_res
	DialogueManager.show_dialogue_balloon(dialoge)

func _on_dialogue_ended(_resource):
	emit_signal("minigame_ended", true)
