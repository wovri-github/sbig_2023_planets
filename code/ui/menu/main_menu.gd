extends PanelContainer

signal play_game()
signal open_settings()
signal open_credits()



func _on_play_pressed():
	emit_signal("play_game")

func _on_settings_pressed():
	emit_signal("open_settings")

func _on_credits_pressed():
	emit_signal("open_credits")

func _on_exit_pressed():
	get_tree().quit()
