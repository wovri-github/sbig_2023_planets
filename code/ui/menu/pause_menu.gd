extends PanelContainer

signal settings_clicked()
signal restart_clicked()



func _on_visibility_changed():
	if is_inside_tree():
		get_tree().set_pause(self.is_visible())

func _on_resume_pressed():
	$UnpauseSound.play()
	self.hide()

func _on_restart_pressed():
	$ConfirmSound.play()
	self.hide()
	emit_signal("restart_clicked")

func _on_settings_pressed():
	$SelectSound.play()
	emit_signal("settings_clicked")

func _on_exit_pressed():
	$ConfirmSound.play()
	get_tree().set_pause(false)
	get_tree().change_scene_to_file("res://code/ui/main_screen.tscn")

