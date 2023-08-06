extends Node

@export var background_sounds: Array[AudioStream]
var background_counter = 0



func _ready():
	fade_in()
	$BackgroundSound.stream = background_sounds[background_counter]
	$BackgroundSound.play()

func _process(delta):
	var length_to_end = $BackgroundSound.stream.get_length() - $BackgroundSound.get_playback_position()
	if length_to_end <= 5:
		fade_out()

func fade_out():
	var tween = self.create_tween()
	tween.tween_property($BackgroundSound, "volume_db", -80, 10)

func fade_in():
	var tween = self.create_tween()
	tween.tween_property($BackgroundSound, "volume_db", 0, 5)
	

func _on_background_sound_finished():
	fade_in()
	background_counter += 1 
	background_counter %= background_sounds.size()
	$BackgroundSound.stream = background_sounds[background_counter]
	$BackgroundSound.play()
