extends PlayerState


func enter() -> void:
	print_debug("entering AIR state")

func exit() -> void:
	pass

func frame_update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	if player.is_on_floor():
		Transition.emit(self,"ground")
		
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()
