extends RigidBody2D

var x_max = 30
var speed_min = 50
var speed_max = 150
var additional_nonliving_speed:int = 0
@export var force_factor = 120
@export var scale_min = 0.5
@export var scale_max = 4
@onready var y_max = get_viewport_rect().size.y
@onready var scalables = [$Pivot, $CollisionShape2D]

var prev_linear_velocity = Vector2.ZERO


func _ready():
	change_size()
	set_up_initial_movement()

func change_size():
	var scale_factor = randf_range(scale_min, scale_max)
	mass = scale_factor
	for scalable in scalables:
		scalable.scale = Vector2(scale_factor, scale_factor)

func set_up_initial_movement():
	var rand_x = randi_range(0, x_max)
	var rand_y = randi_range(0, y_max)
	var rand_speed = randi_range(speed_min, speed_max) + additional_nonliving_speed
	var destination_point = Vector2(rand_x, rand_y)
	var radians_to_destination = self.position.angle_to_point(destination_point)
	self.set_linear_velocity(Vector2(rand_speed, 0).rotated(radians_to_destination))
	prev_linear_velocity = linear_velocity

func _on_body_entered(body):
	$BounceSound.play()
	if body is CharacterBody2D:
		var rad_to_player = prev_linear_velocity.angle_to(body.global_position - self.global_position)
		var speed_force_factor = max(0, -(abs(rad_to_player) - 1.5708)) * 5
		body.knockback(mass * force_factor * speed_force_factor, global_position)
		prev_linear_velocity = linear_velocity

func _on_visible_on_screen_notifier_2d_screen_entered():
	$NotVisibleLifeTime.queue_free()


func _on_life_time_timeout():
	self.queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
