extends EnemyState

var chase_target : Vector2

func enter(context:Dictionary = {}) -> void:
	super()
	if chase_target == Vector2.ZERO:
		enemy.velocity.y -= enemy.JUMP_VELOCITY
	
	animation.play("running")




func exit() -> void:
	super()



func frame_update(delta: float) -> void:
	pass



func physics_update(delta: float) -> void:	
	if (abs(chase_target.x - enemy.position.x) < 10 or enemy.is_on_wall()) and not enemy.have_sight:
		print_debug(str(abs(chase_target.x - enemy.position.x)) + " " + str(enemy.is_on_wall()) + " " + str(enemy.have_sight))
		chase_target = Vector2.ZERO
		enemy.is_chasing = false
		Transition.emit(self,"idling")
		return
	
	if enemy.can_attack and not enemy.is_in_attack_cd:
		Transition.emit(self,"attacking")
		return
	
	chase_target = enemy.get_chase_data()
	var direction = sign(chase_target.x - enemy.global_position.x)
	if direction != 0:
		animation.flip_sprite(direction)
	enemy.velocity.x = move_toward(enemy.velocity.x, enemy.CHASE_SPEED * direction, enemy.ACCELERATION * delta)
	
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()



func on_got_hit(context: Dictionary):
	super(context)

func on_target_found():
	super()

func on_target_lost():
	pass

func on_animation_finished(anim_name: StringName):
	pass
