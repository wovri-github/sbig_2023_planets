extends CharacterBody2D

@export var linear_dumping = 1
@export var exponential_dumping = 0.05
@export var acceleration_factor = 10


func _physics_process(_delta):
	velocity_dumping()
	movement()
	move_and_slide()


func velocity_dumping():
	velocity -= (velocity.normalized() * (linear_dumping + velocity.length() * exponential_dumping))
	if velocity.length() < 5:
		velocity = Vector2.ZERO

func movement():
	var direction = Vector2(int(Input.get_axis("left", "right") * 10), int(Input.get_axis("up", "down") * 10))
	var acceleration = direction.normalized() * acceleration_factor
	velocity += acceleration


func knockback(force, from_position):
	velocity = (global_position - from_position).normalized() * force
