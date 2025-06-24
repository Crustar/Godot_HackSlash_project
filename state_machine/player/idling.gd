extends PlayerState


func enter():
	print_debug("entering IDLING state")

func physics_update(delta: float) -> void:
	# Physic logic
	player.velocity.x = move_toward(player.velocity.x, 0, player.ACCELERATION * delta)
	
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()
	
	
	# Transition logic
	var direction := Input.get_axis("left", "right")
	if direction: # direction pressed -> running state
		Transition.emit(self,"running")
	if !player.is_on_floor(): # player can fall -> falling state
		Transition.emit(self,"falling")
	elif Input.is_action_just_pressed("jump"): # jump pressed -> jumping state
		Transition.emit(self,"jumping")

	

	
	

func frame_update(delta: float) -> void:
	pass
