extends ParallaxBackground

enum BACKGROUND_FRAMES{STATIC, MOVING_LEFT}
var is_moving := false:
	set(val):
		is_moving = val
		set_process(is_moving)
		set_background(is_moving)

func _ready():
	set_process(false)

func _process(delta):
	scroll_base_offset.x -= 200 * delta

func set_background(is_moving):
	if is_moving:
		$ParallaxLayer/Sprite2D.frame = BACKGROUND_FRAMES.MOVING_LEFT
	else:
		$ParallaxLayer/Sprite2D.frame = BACKGROUND_FRAMES.STATIC
