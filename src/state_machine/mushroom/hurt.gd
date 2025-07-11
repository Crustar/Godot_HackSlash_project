extends EnemyState

var direction : int

func enter(context:Dictionary = {}) -> void:
	super()
	
	enemy.toggle_attack(false)
	
	animation.play("hurt")



func exit() -> void:
	super()



func frame_update(delta: float) -> void:
	pass



func physics_update(delta: float) -> void:
	enemy.velocity.x = move_toward(enemy.velocity.x, enemy.PATROL_SPEED * direction, enemy.ACCELERATION * delta)
	
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()



func on_got_hit(context: Dictionary):
	super(context)



func on_animation_finished(anim_name: StringName):
	if enemy.is_dead:
		Transition.emit(self,"dead")
	else:
		enemy.toggle_attack(true)
		enemy.invulnerable = false
		Transition.emit(self,"patrolling")
