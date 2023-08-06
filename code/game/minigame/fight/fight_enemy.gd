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
	$EnemyFlare/LoopEnemyFlare0.trigger()
	damage = planet_res.damage

func start_turn():
	if is_first_attack:
		if flair_up < max_flair_up:
			$Planet.increase_flair_up()
			flair_up += 1
			if flair_up == 1:
				$EnemyFlareUp1.play()
				$EnemyFlare/LoopEnemyFlare1.trigger()
			elif flair_up < 3:
				$EnemyFlareUp2.play()
				$EnemyFlare/LoopEnemyFlare2.trigger()
			elif flair_up == max_flair_up:
				$EnemyFlareUp3.play()
				$EnemyFlare/LoopEnemyFlare3.trigger()
			damage *= 2
			await $Planet/AnimatedSprite2D.animation_finished
			emit_signal("turn_ended")
			return
		is_first_attack = false
		$"../AnimationPlayer".play("enemy_attack")
	if randf() <= 0.5:
		if flair_up < max_flair_up:
			$Planet.increase_flair_up()
			flair_up += 1
			if flair_up == 1:
				$EnemyFlareUp1.play()
				$EnemyFlare/LoopEnemyFlare1.trigger()
			elif flair_up < 3:
				$EnemyFlareUp2.play()
				$EnemyFlare/LoopEnemyFlare2.trigger()
			elif flair_up == max_flair_up:
				$EnemyFlareUp3.play()
				$EnemyFlare/LoopEnemyFlare3.trigger()
			damage *= 2
			await $Planet/AnimatedSprite2D.animation_finished
			emit_signal("turn_ended")
			return
		$"../AnimationPlayer".play("enemy_attack")
	else:
		$"../AnimationPlayer".play("enemy_attack")
		
	
	

