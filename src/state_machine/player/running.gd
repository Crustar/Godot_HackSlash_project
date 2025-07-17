extends PlayerState

# State: running
# behavior:
#	play the running animation
#	character moves in the direction that the player is inputting (left/right)
#	follow passive physic (gravity)
# trasition:
#	player has no horizontal input -> indle
#	character is no longer on the floor -> falling
#	player presses jump and character can jump -> jumping
#	player presses dash and character can dash -> dashing
#	player presses attack -> attack
#	character is hit by an enemy -> delegate to character's reveive_hit signal (to hurt state)

func enter(context:Dictionary = {}) -> void:
	super()
	
	player.jump_count = 0
	player.dash_count = 0
	
	animation.play("running")
	#print_debug("entering RUNNING state")	

func exit() -> void:
	super()
	pass

func frame_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	animation.flip_sprite(direction)

func physics_update(delta: float) -> void:
	# physic logic
	var direction := Input.get_axis("left", "right")
	if direction:
		var target_speed :float = direction * player.SPEED
		player.velocity.x = move_toward(player.velocity.x,target_speed, player.ACCELERATION)
	
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()	
	
	
	# transition logic
	#if !direction : # no more input -> idling state
		#Transition.emit(self,"idling")
	if !player.is_on_floor(): # player can fall -> falling state
		Transition.emit(self,"falling")
	#elif Input.is_action_just_pressed("jump"): # jump pressed -> jumping state
	#	Transition.emit(self,"jumping")
	

func on_player_event(event: String) :
	match event:
		"no_left_no_right":
			Transition.emit(self,"idling")
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
