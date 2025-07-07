extends PlayerState



func enter(context:Dictionary = {}) -> void:
	super()
	animation.play("dead")


	print_debug("entering DEAD state")

func exit() -> void:
	super()
	pass

func frame_update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	# Physic logic
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	
	# Transition logic



func on_player_event(event: String) :
	match event:
		_:
			pass


func on_animation_finished(anim_name: StringName) -> void:
	get_tree().reload_current_scene()
