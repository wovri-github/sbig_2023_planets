extends RigidBody2D

var x_max = 20
var speed = 100
@export var force_factor = 100
@export var scale_min = 0.5
@export var scale_max = 3
@onready var y_max = get_viewport_rect().size.y
@onready var scalables = [$Pivot, $CollisionShape2D]



func _ready():
	change_size()
	set_up_initial_movement()


func _on_body_entered(body):
	if body is CharacterBody2D:
		body.knockback(mass * force_factor, global_position)

func change_size():
	var scale_factor = randf_range(scale_min, scale_max)
	mass = scale_factor
	for scalable in scalables:
		scalable.scale = Vector2(scale_factor, scale_factor)


func set_up_initial_movement():
	var rand_x = randi_range(0, x_max)
	var rand_y = randi_range(0, y_max)
	var destination_point = Vector2(rand_x, rand_y)
	var radians_to_destination = self.position.angle_to_point(destination_point)
	self.set_linear_velocity(Vector2(speed, 0).rotated(radians_to_destination))



func _on_visible_on_screen_notifier_2d_screen_entered():
	$NotVisibleLifeTime.queue_free()


func _on_life_time_timeout():
	self.queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
