extends Node

enum TYPE {
	CUTSCENE,
	TRAVEL,
	FIGHT,
	BOSS_FIGHT,
	GAME_MENU,
	WIN,
}
const MUSIC_FADE_SPEED = {
	"music": 1,
	"trans": 0.75,
}

const MUSIC = {
	TYPE.CUTSCENE: preload("res://assets/music/Dialogue.wav"),
	TYPE.TRAVEL: preload("res://assets/music/Ambience.wav"),
	TYPE.FIGHT: preload("res://assets/music/Combat.wav"),
	TYPE.BOSS_FIGHT: preload("res://assets/music/Boss Dialogue.wav"),
	TYPE.GAME_MENU: preload("res://assets/music/Game Menu.wav"),
	TYPE.WIN: preload("res://assets/music/Boss Fight.wav"),
}
const TRANS = {
	TYPE.CUTSCENE: preload("res://assets/music/Tran Ambience to Dialogue.wav"),
	TYPE.TRAVEL: preload("res://assets/music/Tran Combat to Ambience.wav"),
	TYPE.FIGHT:preload("res://assets/music/Tran Dialogue to Combat.wav"),
	TYPE.BOSS_FIGHT: preload("res://assets/music/Tran Ambience to Dialogue Boss.wav"),
}
@export var play_music: TYPE = TYPE.GAME_MENU:
	set(val):
		play_music = val
		change_music_to(play_music)
@onready var tween
var is_trans := false
var is_fadeing_out: bool = false


func _ready():
	fade_in()
	$BackgroundSound.stream = MUSIC[TYPE.GAME_MENU]
	$BackgroundSound.play()

func _process(delta):
	if is_trans and $BackgroundSound.stream.get_length() - $BackgroundSound.get_playback_position() <= MUSIC_FADE_SPEED.trans and not is_fadeing_out:
		is_fadeing_out = true
		fade_out(MUSIC_FADE_SPEED.trans)

func change_music_to(type: TYPE):
	await fade_out()
	if TRANS.has(type):
		fade_in(MUSIC_FADE_SPEED.trans)
		is_trans = true
		$BackgroundSound.stream = TRANS[type]
		$BackgroundSound.play()
		await $BackgroundSound.finished
	fade_in()
	is_trans = false
	$BackgroundSound.stream = MUSIC[type]
	$BackgroundSound.play()
	
	

func fade_out(speed = 1):
	if tween:
		tween.kill()
	tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tween.tween_property($BackgroundSound, "volume_db", -25, speed)
	await tween.finished
	is_fadeing_out = false

func fade_in(speed = 1):
	if tween:
		tween.kill()
	tween = self.create_tween()
	$BackgroundSound.volume_db = -40
	tween.tween_property($BackgroundSound, "volume_db", 0, speed)


#func _on_background_sound_finished():
#	fade_in()
#	background_counter += 1 
#	background_counter %= background_sounds.size()
#	$BackgroundSound.stream = background_sounds[background_counter]
#	await get_tree().process_frame
#	$BackgroundSound.play()
