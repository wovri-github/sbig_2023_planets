extends CharacterBody2D

@export var speed: int = 100




func _physics_process(_delta):
	movement()

func movement():
	velocity.x = int(Input.get_axis("left", "right") * 10)
	velocity.y = int(Input.get_axis("up", "down") * 10)
	velocity = velocity.normalized()
	velocity *= speed
	move_and_slide()
