extends PlayerState


func enter():
	print_debug("entering RUNNING state")	

func exit():
	pass

func physics_update(delta: float) -> void:
	# physic logic
	var direction := Input.get_axis("left", "right")
	if direction:
		var target_speed :float = direction * player.SPEED
		player.velocity.x = move_toward(player.velocity.x,target_speed, player.ACCELERATION)
	
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()	
	
	
	# transition logic
	if !direction : # no more input -> idling state
		Transition.emit(self,"idling")
	if !player.is_on_floor(): # player can fall -> falling state
		Transition.emit(self,"falling")
	elif Input.is_action_just_pressed("jump"): # jump pressed -> jumping state
		Transition.emit(self,"jumping")
	
	
	

func frame_update(delta: float) -> void:
	pass
