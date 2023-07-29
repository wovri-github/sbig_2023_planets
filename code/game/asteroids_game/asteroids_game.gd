extends Node2D

@export var space_object_tscn: PackedScene
@onready var nonliving_spawn_point = $NonlivingSpawn

func _ready():
	spawn_space_object()

func spawn_space_object():
	var space_object_inst = space_object_tscn.instantiate()
	space_object_inst.set_position(nonliving_spawn_point.position)
	space_object_inst.set_linear_velocity(Vector2(-10, 0))
	add_child(space_object_inst)
