extends PlayerState


func enter() -> void:
	super()
	animation.play("idling")
	print_debug("entering IDLING state")

func exit() -> void:
	super()
	pass
	
func frame_update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	# Physic logic
	player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
	
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()
	
	
	# Transition logic
	#var direction := Input.get_axis("left", "right")
	#if direction: # direction pressed -> running state
		#Transition.emit(self,"running")
	if !player.is_on_floor(): # player can fall -> falling state
		Transition.emit(self,"falling")
	#elif Input.is_action_just_pressed("jump"): # jump pressed -> jumping state
		#Transition.emit(self,"jumping")


func on_player_event(event: String) :
	match event:
		"left":
			Transition.emit(self,"running")
		"right":
			Transition.emit(self,"running")
		"jump":
			Transition.emit(self,"jumping")
		_:
			pass
	
