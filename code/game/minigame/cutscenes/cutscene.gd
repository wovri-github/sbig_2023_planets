extends Minigame

@export var dialoge: DialogueResource
@export var player: Actor
@export var enemy: Actor



func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func enter():
	DialogueManager.show_dialogue_balloon(dialoge)

func _on_dialogue_ended():
	emit_signal("minigame_ended")
