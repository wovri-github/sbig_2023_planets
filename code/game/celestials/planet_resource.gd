extends Resource
class_name PlanetResource

@export var sprite_frames: SpriteFrames
@export var dialogue_name: String = "Planet"
@export var color: Color = Color.BLACK
@export_category("Fight Statistics")
@export var health: int = 20
@export var damage: int = 10
@export var voice: Array[AudioStream]
@export var attack_sound: Array[AudioStream]
@export var hurt_sound: Array[AudioStream]
@export var oh_sound: Array[AudioStream]
