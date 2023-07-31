@tool
extends Minigame

@export var space_object_tscn: PackedScene
@export var sec_before_stoping_spawn: float = 3
@export var is_debug: bool = true
var spawn_point_width = 200
var default_position = Vector2(120, 150)
@onready var player = $Player
@onready var nonliving_spawn_point = $NonlivingSpawn
@onready var spawn_timer = $NonlivingSpawn/SpawnTimer

func _ready():
	if Engine.is_editor_hint():
		return
	if is_debug:
		enter({})
	else:
		self.process_mode = Node.PROCESS_MODE_DISABLED

func enter(data):
	$GameTime.start()


func spawn_space_object():
	var space_object_inst = space_object_tscn.instantiate()
	var random_y_spawn_point = randi_range(-spawn_point_width, spawn_point_width)
	var _current_spawn_point = nonliving_spawn_point.position + Vector2(0, random_y_spawn_point)
	space_object_inst.set_position(_current_spawn_point)
	add_child(space_object_inst)


func _on_spawn_timer_timeout():
	if $GameTime.time_left < sec_before_stoping_spawn:
		spawn_timer.stop()
		return
	spawn_space_object()


func _on_game_time_timeout():
	var tween = get_tree().create_tween()
	var distance = player.position.distance_to(default_position)
	var time = distance / player.speed
	tween.tween_property(player, "position", default_position, time)
	await tween.finished
	emit_signal("minigame_ended")
