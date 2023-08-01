extends CanvasLayer


func _on_main_menu_continue_clicked():
	await Storage.load_save()
	get_tree().change_scene_to_file("res://code/game/game.tscn")

func _on_main_menu_new_game_clicked():
	get_tree().change_scene_to_file("res://code/game/game.tscn")


func _on_main_menu_open_settings():
	$Settings.open()

func _on_main_menu_open_credits():
	$Credits.open()


