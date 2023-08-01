extends CanvasLayer

@onready var pause_menu = $PauseMenu
@onready var settings_menu = $Settings
@onready var died_menu = $DiedMenu



func _input(event):
	if event.is_action_pressed("menu"):
		if settings_menu.is_visible():
			settings_menu.hide()
			return
		if died_menu.is_visible():
			return
		pause_menu.visible = !pause_menu.visible

func _on_player_died():
	died_menu.show()

func _on_settings_clicked():
	settings_menu.show()
