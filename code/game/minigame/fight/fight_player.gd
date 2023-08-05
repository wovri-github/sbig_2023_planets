extends Fighter

@onready var attack_button = %Buttons/Attack
@onready var flair_up_button = %Buttons/FlairUp
var animation_ended = false



func _init():
	fighter = Fighter.TYPE.PLAYER

func setup_complete():
	attack_button.text = "Attack %d" % damage

func start_turn():
	for button in [attack_button, flair_up_button]:
		button.disabled = false
		if button == flair_up_button:
			if flair_up >= 3:
				flair_up_button.disabled = true

func end_turn():
	for button in [attack_button, flair_up_button]:
		button.disabled = true
			
	


func _on_attack_pressed():
	$"../AnimationPlayer".play("player_attack")

func reset_flair_up():
	$Planet.idle()
	flair_up = 0
	damage = planet_res.damage
	flair_up_button.text = "Flair up %d/3" % flair_up
	setup_complete()


func _on_flair_up_pressed():
	animation_ended = false
	$Planet.increase_flair_up()
	flair_up += 1
	damage *= 2
	setup_complete()
	flair_up_button.text = "Flair up %d/3" % flair_up
	await $Planet/AnimatedSprite2D.animation_finished
	if not animation_ended:
		animation_ended = true
		emit_signal("turn_ended")
	
