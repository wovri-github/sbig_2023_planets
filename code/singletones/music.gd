extends Node

@export var background_sounds: Array[AudioStream]
var background_counter = 0

@onready var tween

func _ready():
	fade_in()
	$BackgroundSound.stream = background_sounds[background_counter]
	$BackgroundSound.play()

func _process(delta):
	var length_to_end = $BackgroundSound.stream.get_length() - $BackgroundSound.get_playback_position()
	if length_to_end <= 10:
		fade_out()

func fade_out():
	if tween:
		tween.kill()
	await get_tree().process_frame
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($BackgroundSound, "volume_db", -40, 10)

func fade_in():
	if tween:
		tween.kill()
	await get_tree().process_frame
	tween = self.create_tween()
	tween.tween_property($BackgroundSound, "volume_db", 0, 5)


func _on_background_sound_finished():
	fade_in()
	background_counter += 1 
	background_counter %= background_sounds.size()
	$BackgroundSound.stream = background_sounds[background_counter]
	await get_tree().process_frame
	$BackgroundSound.play()
