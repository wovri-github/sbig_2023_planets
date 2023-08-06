extends Fighter

var is_first_attack = true


func _init():
	fighter = Fighter.TYPE.ENEMY

func _ready():
	$Planet.is_mad = true
	$Planet.idle()


func reset_flair_up():
	$Planet.idle()
	flair_up = 0
	damage = planet_res.damage

func start_turn():
	if is_first_attack:
		if flair_up < max_flair_up:
			$Planet.increase_flair_up()
			flair_up += 1
			damage *= 2
			await $Planet/AnimatedSprite2D.animation_finished
			emit_signal("turn_ended")
			return
		is_first_attack = false
		$AudioStreamPlayer2D.stream = planet_res.attack_sound.pick_random()
		$AudioStreamPlayer2D.play()
		$"../AnimationPlayer".play("enemy_attack")
	if randf() <= 0.5:
		if flair_up < max_flair_up:
			$Planet.increase_flair_up()
			flair_up += 1
			damage *= 2
			await $Planet/AnimatedSprite2D.animation_finished
			emit_signal("turn_ended")
			return
		$AudioStreamPlayer2D.stream = planet_res.attack_sound.pick_random()
		$AudioStreamPlayer2D.play()
		$"../AnimationPlayer".play("enemy_attack")
	else:
		$AudioStreamPlayer2D.stream = planet_res.attack_sound.pick_random()
		$AudioStreamPlayer2D.play()
		$"../AnimationPlayer".play("enemy_attack")
		
	
	

