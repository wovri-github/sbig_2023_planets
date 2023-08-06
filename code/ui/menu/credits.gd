extends DefaultMenu


#func _ready():
#	self.hide()

func _on_hide_pressed():
	$ConfirmSound.play()
	super.close()
	if get_parent() == get_tree().get_root():
		get_tree().change_scene_to_file("res://code/ui/main_screen.tscn")
