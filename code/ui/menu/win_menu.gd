extends PanelContainer



func _on_exit_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://code/ui/menu/credits.tscn")
