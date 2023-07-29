extends Node2D

@export var space_object_tscn: PackedScene
var spawn_point_width = 200
@onready var nonliving_spawn_point = $NonlivingSpawn



func spawn_space_object():
	var space_object_inst = space_object_tscn.instantiate()
	var random_y_spawn_point = randi_range(-spawn_point_width, spawn_point_width)
	var _current_spawn_point = nonliving_spawn_point.position + Vector2(0, random_y_spawn_point)
	space_object_inst.set_position(_current_spawn_point)
	add_child(space_object_inst)


func _on_spawn_timer_timeout():
	spawn_space_object()
