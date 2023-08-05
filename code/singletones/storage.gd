extends Node
#Storage
signal saved()

const SAVE_FILE = "user://save.ini"
var current: ConfigFile = ConfigFile.new()
var do_save_exist = FileAccess.file_exists("user://save.ini")

func _ready():
	if do_save_exist:
		current.load(SAVE_FILE)

func remove_game_save():
	if current.has_section("game"):
		current.erase_section("game")
		save()

func save():
	current.save(SAVE_FILE)
	emit_signal("saved")

func set_value(section: String, key: String, value: Variant):
	current.set_value(section, key, value)
	save()

func get_value(section: String, key: String, default: Variant = null) -> Variant:
	if not current.has_section_key(section, key):
		return default
	else:
		return current.get_value(section, key)
