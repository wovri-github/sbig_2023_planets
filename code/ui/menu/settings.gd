extends DefaultMenu

var settings: Settings = preload("res://code/settings/settings.tres")
@onready var brightness_slider = $Margin/VBox/Brightness/HSlider
@onready var sound_slider = $Margin/VBox/Sound/HSlider


func _ready():
	await get_tree().physics_frame
	var loaded_brightness = Storage.get_value("settings", "brightness", 0.7)
	brightness_slider.value = loaded_brightness
	sound_slider.value = AudioServer.get_bus_volume_db(0)
	settings.brightness = loaded_brightness


func _on_close_pressed():
	$ConfirmSound.play()
	super.close()


func _on_h_slider_value_changed(value):
	settings.brightness = value


func _on_h_slider_drag_ended(value_changed):
	$ConfirmSound.play()
	Storage.set_value("settings", "brightness", settings.brightness)


func _on_sound_h_slider_value_changed(value):
	$SelectSound.play()
	AudioServer.set_bus_volume_db(0, value)
	if value <= -19:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
