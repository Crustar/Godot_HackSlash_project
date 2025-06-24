extends PlayerState


func enter() -> void:
	player.velocity.y += - player.JUMP_VELOCITY
	animation.play("jumping")
	print_debug("entering JUMPING state")

func exit() -> void:
	pass

func frame_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	animation.flip_sprite(direction)

func physics_update(delta: float) -> void:
	# Physic logic
	var direction := Input.get_axis("left", "right")
	if direction:
		var target_speed :float = direction * player.SPEED
		player.velocity.x = move_toward(player.velocity.x,target_speed, player.ACCELERATION * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
	
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()
	
	# Transition logic
	if player.velocity.y > 0: # player no longer jumping UP -> falling state
		Transition.emit(self,"falling")
	if player.is_on_floor(): # player just landed and...
		if direction: # ...directional input is present -> running state
			Transition.emit(self,"running")
		else: # ...directional input in absent -> idling state 
			Transition.emit(self,"idling")
		
