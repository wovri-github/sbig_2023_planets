extends PanelContainer

signal settings_clicked()



func _on_visibility_changed():
	if is_inside_tree():
		get_tree().set_pause(self.is_visible())

func _on_resume_pressed():
	self.hide()

func _on_settings_pressed():
	emit_signal("settings_clicked")

func _on_exit_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://code/ui/main_screen.tscn")
