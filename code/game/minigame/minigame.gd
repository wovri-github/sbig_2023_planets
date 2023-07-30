extends CanvasLayer
class_name Minigame

enum {ASTEROIDS, TURN_FIGHT}


func _enter():
	self.show()
	self.set_process_mode(PROCESS_MODE_INHERIT)
	enter()

func _exit():
	self.hide()
	self.set_process_mode(PROCESS_MODE_DISABLED)
	exit()


func enter():
	pass

func exit():
	pass
