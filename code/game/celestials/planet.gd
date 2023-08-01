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

var highlight := true:
	set(value):
		highlight = value
		if highlight == true:
			self.modulate = highlight_color
		else:
			self.modulate = no_highlight_color
			

@onready var dialogue_name = planet_resource.dialogue_name
@onready var health: int = planet_resource.health
@onready var damage: int = planet_resource.damage

func _ready():
	$AnimatedSprite2D.sprite_frames = planet_resource.sprite_frames

