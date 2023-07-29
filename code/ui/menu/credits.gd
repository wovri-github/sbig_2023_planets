extends DefaultMenu


func _ready():
	self.hide()

func _on_hide_pressed():
	super.close()
