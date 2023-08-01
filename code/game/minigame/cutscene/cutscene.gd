@tool
extends Minigame

@export var minigame_debug_data: MinigameData
var dialoge: DialogueResource
var own_balloon_tscn = preload("res://code/own_dialogue_box/balloon.tscn")
@onready var player: Planet = $Player
@onready var enemy: Planet = $Enemy



func _ready():
	if Engine.is_editor_hint():
		return
	if is_debug:
		enter(minigame_debug_data)
		$Camera2D.enabled = true
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
	await $UI.show_borders()
	show_dialogue_balloon(dialoge)


func show_dialogue_balloon(resource: DialogueResource, title: String = "0", extra_game_states: Array = []):
	var balloon: Node = own_balloon_tscn.instantiate()
	add_child(balloon)
	balloon.player = player
	balloon.enemy = enemy
	balloon.start(resource, title, extra_game_states)

func _on_dialogue_ended(_resource):
	player.highlight = true
	enemy.highlight = true
	await $UI.hide_borders()
	emit_signal("minigame_ended", true)
