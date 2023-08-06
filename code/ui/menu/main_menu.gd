extends PanelContainer

signal continue_clicked()
signal new_game_clicked()
signal open_settings()
signal open_credits()


func _ready():
	if OS.has_feature("web"):
		$Margin/VBox/Exit.disabled = true
	if Storage.do_save_exist:
		$Margin/VBox/Continue.disabled = false
	else:
		$Margin/VBox/Continue.disabled = true

func _on_continue_pressed():
	$UnpauseSound.play()
	emit_signal("continue_clicked")

func _on_new_game_pressed():
	$UnpauseSound.play()
	emit_signal("new_game_clicked")

func _on_settings_pressed():
	$ConfirmSound.play()
	emit_signal("open_settings")

func _on_credits_pressed():
	$ConfirmSound.play()
	emit_signal("open_credits")

func _on_exit_pressed():
	$ConfirmSound.play()
	get_tree().quit()
