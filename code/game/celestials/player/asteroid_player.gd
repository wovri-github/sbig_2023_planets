extends CharacterBody2D

@export var speed: int = 100
var input_vector: Vector2



func _unhandled_input(event):
	var x_axis: int = Input.get_axis("left", "right") * 10
	var y_axis: int = Input.get_axis("up", "down") * 10
	input_vector = Vector2.ZERO
	if x_axis:
		input_vector.x = x_axis
	if y_axis:
		input_vector.y = y_axis

func _physics_process(delta):
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
