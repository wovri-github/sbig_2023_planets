@tool
extends Minigame


@export var space_object_tscn: PackedScene
@export var sec_before_stoping_spawn: float = 3
var spawn_point_width = 200
@onready var player = $Player
@onready var nonliving_spawn_point = $NonlivingSpawn
@onready var spawn_timer = $NonlivingSpawn/SpawnTimer



func _ready():
	if Engine.is_editor_hint():
		return
	if is_debug:
		enter()
		minigame_ended.connect(enter)
	else:
		self.process_mode = Node.PROCESS_MODE_DISABLED

func enter(data = {}):
	$GameTime.start()
	spawn_timer.start()
	player.position = Defaults.START_POSITION
	player.velocity = Vector2.ZERO



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

func end_game():
	get_tree().call_group("nonlivings", "queue_free")
	var tween = get_tree().create_tween()
	var distance = player.position.distance_to(Defaults.START_POSITION)
	var time = distance / (player.acceleration_factor * 10)
	tween.tween_property(player, "position", Defaults.START_POSITION, time)
	await tween.finished

func _on_game_time_timeout():
	await end_game()
	emit_signal("minigame_ended", true)


func _on_visible_on_screen_notifier_2d_2_screen_exited():
	if $GameTime.is_stopped():
		return
	get_tree().call_group("nonlivings", "queue_free")
	emit_signal("minigame_ended", false)
