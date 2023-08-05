extends CanvasModulate

var settings: Settings = preload("res://code/settings/settings.tres")

func _ready():
	settings.brightness_changed.connect(_on_brightness_changed)

func _on_brightness_changed():
	var brightness = settings.brightness
	self.color = Color(brightness, brightness, brightness)
