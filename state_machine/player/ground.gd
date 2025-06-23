extends PlayerState


func enter():
	print_debug("entering GROUND state")

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = - player.JUMP_VELOCITY
		Transition.emit(self,"air")
	
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()
	
	if !player.is_on_floor():
		Transition.emit(self,"air")
	

func frame_update(delta: float) -> void:
	pass
