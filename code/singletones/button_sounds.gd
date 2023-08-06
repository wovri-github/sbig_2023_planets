extends Node

func _ready():
	connect_buttons(get_tree().root)
	get_tree().node_added.connect(_on_SceneTree_node_added)

func _on_SceneTree_node_added(node):
	if node is Button:
		connect_to_button(node)

func _on_Button_pressed():
	$ClickSound.play()
func _on_mouse_entered():
	$SelectSound.play()

# recursively connect all buttons
func connect_buttons(root):
	for child in root.get_children():
		if child is BaseButton:
			connect_to_button(child)
		connect_buttons(child)

func connect_to_button(button):
	button.pressed.connect(_on_Button_pressed)
	button.mouse_entered.connect(_on_mouse_entered)
