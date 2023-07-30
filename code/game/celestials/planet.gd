@tool
extends Node2D
class_name Planet

@export var planet_resource: PlanetResource:
	set(new_planet_res):
		planet_resource = new_planet_res
		dialogue_name = planet_resource.dialogue_name
		health = planet_resource.health
		damage = planet_resource.damage
		self.modulate = planet_resource.color
@onready var dialogue_name = planet_resource.dialogue_name
@onready var health: int = planet_resource.health
@onready var damage: int = planet_resource.damage

func _ready():
	$AnimatedSprite2D.sprite_frames = planet_resource.sprite_frames
