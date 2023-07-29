extends CanvasLayer



func _on_main_menu_play_game():
	get_tree().change_scene_to_file("res://code/game/asteroids_game/asteroids_game.tscn")


func _on_main_menu_open_settings():
	$Settings.open()


func _on_main_menu_open_credits():
	$Credits.open()

