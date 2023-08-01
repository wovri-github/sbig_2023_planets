extends CanvasLayer

@onready var up_border_high = abs($UpBorder.size.y)
@onready var up_border_final_position = $UpBorder.position.y
@onready var down_border_high = abs($DownBorder.size.y)
@onready var down_border_final_position = $DownBorder.position.y

func _ready():
	$UpBorder.position.y -= up_border_high
	$DownBorder.position.y += down_border_high

func show_borders():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($UpBorder, "position", Vector2(0,up_border_final_position), 1)
	tween.tween_property($DownBorder, "position", Vector2(0,down_border_final_position), 1)
	await tween.finished

func hide_borders():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($UpBorder, "position", Vector2(0,$UpBorder.position.y-up_border_high), 1)
	tween.tween_property($DownBorder, "position", Vector2(0,$DownBorder.position.y+down_border_high), 1)
	await tween.finished
