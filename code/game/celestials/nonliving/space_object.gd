extends RigidBody2D


func _on_visible_on_screen_notifier_2d_screen_exited():
	self.queue_free()
#Extra knockback

func _on_life_time_timeout():
	self.queue_free()
