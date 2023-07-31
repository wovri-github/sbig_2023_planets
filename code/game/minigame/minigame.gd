extends CanvasLayer
class_name Minigame

signal minigame_ended()

@export var is_visible: bool = true:
	set(new_value):
		is_visible = new_value
		self.visible = is_visible
		for node in get_children():
			if node.has_method("is_visible"):
				node.visible = is_visible

enum TYPE{CUTSCENE, TRAVEL, FIGHT}


func _enter(data):
	enter(data)
	is_visible = true
	self.set_process_mode(PROCESS_MODE_INHERIT)

func _exit():
	exit()
	is_visible = false
	self.set_process_mode(PROCESS_MODE_DISABLED)


func enter(_data):
	pass

func exit():
	pass
