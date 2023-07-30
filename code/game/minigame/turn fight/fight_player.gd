extends Fighter


@onready var action_buttons = %Buttons.get_children()

func _init():
	fighter = Fighter.TYPE.PLAYER


func start_turn():
	for button in action_buttons:
		button.disabled = false

func end_turn():
	for button in action_buttons:
		button.disabled = true
	


func _on_attack_pressed():
	enemy.get_damage(damage)

func _on_defend_pressed():
	print("Something for defend?")
