extends PlayerState

# State: attacking
# behavior:
#	play the attacking animation (which also activate hitbox)
#	slow down character movement
#	follow passive physic (gravity)
# trasition:
#	under the input window:
#		player presses jump and character can jump -> jumping
#		player presses dash and character can dash -> dashing
#		player presses attack -> attack2 (combo)
#	character is hit by an enemy -> delegate to character's reveive_hit signal (to hurt state)

@export var can_input: bool= false

const speed_mod = 0.1

var facing : int

func enter(context:Dictionary = {}) -> void:
	super()
	facing = animation.sprite.scale.x
	animation.play("attacking")
	AudioController.play_sound("Attack",0.1)
	#print_debug("entering ATTACKING state")

func exit() -> void:
	super()
	AudioController.stop_sound("Attack")

func frame_update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	# Physic logic
	var direction := Input.get_axis("left", "right")
	if facing == direction:
		player.velocity.x = move_toward(player.velocity.x, player.SPEED * speed_mod * direction, player.ACCELERATION * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)	
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	




func on_player_event(event: String) :
	if can_input:
		match event:
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
				Transition.emit(self,"attacking2")
			_:
				pass


func on_animation_finished(anim_name: StringName) -> void:
	var direction := Input.get_axis("left", "right")
	if player.is_on_floor(): 
		if direction: 
			Transition.emit(self,"running")
		else: 
			Transition.emit(self,"idling")
	else:
		Transition.emit(self,"falling")

func on_player_hit(context: Dictionary):
	super(context)
