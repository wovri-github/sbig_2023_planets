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
	DialogueSignals.do_animation.connect(_on_do_animation)
	DialogueSignals.dialogue_result.connect(_on_dialogue_result)
	DialogueSignals.change_planet_animation.connect(_on_change_planet_animation)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func enter(data: MinigameData):
	if data.c_dialoge_res == null:
		printerr("[Cutscene]: Cutscene Entered but dialogue not found!")
		emit_signal("minigame_ended", true)
		return
	if data.c_animation_name != "":
		$AnimationPlayer.play(data.c_animation_name)
	dialoge = data.c_dialoge_res
	if data.c_enemy_res == null:
		enemy.hide()
	else:
		enemy.show()
		enemy.is_mad = data.c_is_mad
		enemy.idle()
		enemy.planet_resource = data.c_enemy_res
	await $UI.show_borders()
	show_dialogue_balloon(dialoge)

func _input(event):
	if event.is_action_pressed("skip"):
		$AnimationPlayer.play("RESET")

func show_dialogue_balloon(resource: DialogueResource, title: String = "0", extra_game_states: Array = []):
	var balloon: Node = own_balloon_tscn.instantiate()
	add_child(balloon)
	balloon.player = player
	balloon.enemy = enemy
	balloon.start(resource, title, extra_game_states)

func _on_do_animation(anim_name, is_reverse = false):
	if is_reverse:
		$AnimationPlayer.play(anim_name, -1, -1, true)
	else:
		$AnimationPlayer.play(anim_name)

func _on_change_planet_animation(anim_name):
	if anim_name == "tickle":
		enemy.tickle()

func _on_dialogue_result(result):
	if result == false:
		emit_signal("minigame_ended", false)

func _on_dialogue_ended(_resource):
	player.highlight = true
	enemy.highlight = true
	await $UI.hide_borders()
	emit_signal("minigame_ended", true)
