extends CanvasLayer
class_name Minigame

signal minigame_ended()

enum TYPE{CUTSCENE, ASTEROIDS, TURN_FIGHT}


func _enter():
	enter()
	self.show()
	self.set_process_mode(PROCESS_MODE_INHERIT)

func _exit():
	exit()
	self.hide()
	self.set_process_mode(PROCESS_MODE_DISABLED)


func enter():
	pass

func exit():
	pass
