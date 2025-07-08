extends PlayerState

const speed_mod = 0.1

var facing : int

func enter(context:Dictionary = {}) -> void:
	super()
	facing = animation.sprite.scale.x
	animation.play("attacking")
	AudioController.play_attack_sound(0.1)
	print_debug("entering ATTACKING state")

func exit() -> void:
	super()
	pass

func frame_update(delta: float) -> void:
	pass
	#var direction := Input.get_axis("left", "right")
	#animation.flip_sprite(direction)

func physics_update(delta: float) -> void:
	# Physic logic
	var direction := Input.get_axis("left", "right")
	if facing == direction:
		player.velocity.x = move_toward(player.velocity.x, player.SPEED * speed_mod * direction, player.ACCELERATION * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)	
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	
	# Transition logic



func on_player_event(event: String) :
	match event:
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
	if player.invulnerable == false:
		Transition.emit(self,"hurt",context	)
