@tool
extends Node2D
class_name Planet


@onready var  highlight_color = self.modulate
@onready var  no_highlight_color = self.modulate * 0.9
@export var planet_resource: PlanetResource:
	set(new_planet_res):
		planet_resource = new_planet_res
		dialogue_name = planet_resource.dialogue_name
		health = planet_resource.health
		damage = planet_resource.damage
		self.modulate = planet_resource.color
		highlight_color = self.modulate
		no_highlight_color = self.modulate * 0.9
		if is_instance_valid(get_node_or_null("AnimatedSprite2D")):
			$AnimatedSprite2D.sprite_frames = planet_resource.sprite_frames

var highlight := true:
	set(value):
		highlight = value
		if highlight == true:
			self.modulate = highlight_color
		else:
			self.modulate = no_highlight_color
var is_mad: bool = false
var flair_up = 0
@onready var floating_tween: Tween = self.create_tween().set_loops()
@onready var dialogue_name = planet_resource.dialogue_name
@onready var health: int = planet_resource.health
@onready var damage: int = planet_resource.damage



func _ready():
	idle()
	floating()

func floating():
	floating_tween.tween_property($AnimatedSprite2D, "position:y", 5, 1)
	floating_tween.tween_property($AnimatedSprite2D, "position:y", -5, 1)
	

func idle():
	$AnimatedSprite2D.offset.y = 0
	flair_up = 0
	if is_mad:
		$AnimatedSprite2D.animation = "idle_mad"
	elif dialogue_name == "Sun" and DialogueVaribles.was_sunglasses:
		$AnimatedSprite2D.animation = "idle_sunglass"
	else:
		$AnimatedSprite2D.animation = "idle"

func talking():
	$AnimatedSprite2D.offset.y = 0
	flair_up = 0
	if is_mad:
		$AnimatedSprite2D.play("talking_mad")
	elif dialogue_name == "Sun" and DialogueVaribles.was_sunglasses:
		$AnimatedSprite2D.animation = "talking_sunglass"
	else:
		$AnimatedSprite2D.play("talking")

func tickle():
	if dialogue_name == "Sun" and DialogueVaribles.was_sunglasses:
		$AnimatedSprite2D.animation = "laugh_sunglass"
	else:
		$AnimatedSprite2D.play("laugh")
	

func scream():
	$AnimatedSprite2D.offset.y = 0
	flair_up = 0
	if is_mad:
		$AnimatedSprite2D.animation = "talking_mad"
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 4
	else:
		$AnimatedSprite2D.animation = "talking"
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame = 4
	

func increase_flair_up():
	$AnimatedSprite2D.offset.y = -76
	flair_up += 1
	var anim_flair_up = flair_up
	if flair_up >= 4:
		return
	$AnimatedSprite2D.play("init_flair_up%d" % anim_flair_up)
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("flair_up%d" % anim_flair_up)
