extends PlayerState

const speed_mod = 0.1

func enter() -> void:
	super()
	animation.play("attacking")
	print_debug("entering ATTACKING state")

func exit() -> void:
	super()
	pass

func frame_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	animation.flip_sprite(direction)

func physics_update(delta: float) -> void:
	# Physic logic
	var direction := Input.get_axis("left", "right")
	player.velocity.x = move_toward(player.velocity.x, player.SPEED * speed_mod * direction, player.ACCELERATION * delta)
		
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	
	# Transition logic



func on_player_event(event: String) :
	match event:
		_:
			pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	var direction := Input.get_axis("left", "right")
	if player.is_on_floor(): 
		if direction: 
			Transition.emit(self,"running")
		else: 
			Transition.emit(self,"idling")
	else:
		Transition.emit(self,"falling")


func _on_attack_zone_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
