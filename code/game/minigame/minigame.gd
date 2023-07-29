extends CanvasLayer
class_name Minigame

enum {ASTEROIDS, TURN_FIGHT}


func _enter():
	self.show()
	self.set_process(false)
	self.set_physics_process(false)
	enter()

func _exit():
	self.hide()
	self.set_process(true)
	self.set_physics_process(true)
	exit()


func enter():
	pass

func exit():
	pass
