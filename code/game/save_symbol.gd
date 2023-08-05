extends TextureRect


func _ready():
	self.modulate.a = 0
	Storage.saved.connect(_on_saved)

func _on_saved():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.7)
	tween.tween_interval(0.3)
	tween.tween_property(self, "modulate:a", 0, 0.3)
