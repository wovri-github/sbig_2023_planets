extends Resource
class_name Settings

signal brightness_changed()

var brightness: float = 0.7:
	set(new_val):
		brightness = new_val
		emit_signal("brightness_changed")
