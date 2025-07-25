extends PlayerState

# State: idling
# behavior:
#	play and loop idle animation
#	follow passive physic (gravity)
# trasition:
#	character no longer on the floor -> falling
#	player presses left/right -> running
#	player presses jump and character can jump -> jumping
#	player presses dash and character can dash -> dashing
#	player presses attack -> attack
#	character is hit by an enemy -> delegate to character's reveive_hit signal (to hurt state)

func enter(context:Dictionary = {}) -> void:
	super()
	
	player.jump_count = 0
	player.dash_count = 0
	
	animation.play("idling")
	#print_debug("entering IDLING state")

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
			if player.jump_count < player.max_jump:
				player.velocity.y = - player.JUMP_VELOCITY
				player.jump_count += 1
				Transition.emit(self,"jumping")
		"dash":
			if player.dash_count < player.max_dash :
				player.dash_count += 1
				Transition.emit(self,"dashing")
		"attack":
			Transition.emit(self,"attacking")
		_:
			pass
	
func on_player_hit(context: Dictionary):
	super(context)
	
