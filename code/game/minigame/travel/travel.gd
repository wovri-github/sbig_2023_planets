@tool
extends Minigame


@export var space_objects_tscn: Array[PackedScene]
var sec_before_stoping_spawn: float = 10.0
var spawn_point_width = 200

var additional_nonliving_speed = 0
var hard_factor: float = 1

@onready var player = $Player
@onready var nonliving_spawn_point = $NonlivingSpawn
@onready var spawn_timer = $NonlivingSpawn/SpawnTimer



func _ready():
	if Engine.is_editor_hint():
		return
	if is_debug:
		var data = load("res://resources/minigame_data/asteroids1.tres")
		enter(data)
	else:
		self.process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta):
	if $GameTime != null:
		$UI/Label.text = "Distance remaining: %d" % ($GameTime.get_time_left()*48.95)

func enter(data: MinigameData):
	$GameTime.start(data.t_minigame_time)
	spawn_timer.start(data.t_sec_every_nonliving_spawn * (1/hard_factor))
	additional_nonliving_speed = data.t_additional_nonliving_speed * hard_factor
	player.position = Defaults.START_POSITION
	player.velocity = Vector2.ZERO

func exit():
	get_tree().call_group("nonlivings", "queue_free")


func spawn_space_object():
	var space_object_inst = space_objects_tscn.pick_random().instantiate()
	var random_y_spawn_point = randi_range(-spawn_point_width, spawn_point_width)
	var _current_spawn_point = nonliving_spawn_point.position + Vector2(0, random_y_spawn_point)
	space_object_inst.set_position(_current_spawn_point)
	space_object_inst.additional_nonliving_speed = additional_nonliving_speed
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
	hard_factor = 1
	emit_signal("minigame_ended", true)


func _on_visible_on_screen_notifier_2d_2_screen_exited():
	if $GameTime.is_stopped():
		return
	hard_factor = 0.5
	emit_signal("minigame_ended", false)
