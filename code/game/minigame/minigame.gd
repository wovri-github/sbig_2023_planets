extends CanvasLayer
class_name Minigame

signal minigame_ended()

enum TYPE{CUTSCENE, TRAVEL, FIGHT}


func _enter(data):
	enter(data)
	self.show()
	self.set_process_mode(PROCESS_MODE_INHERIT)

func _exit():
	exit()
	self.hide()
	self.set_process_mode(PROCESS_MODE_DISABLED)


func enter(_data):
	pass

func exit():
	pass
