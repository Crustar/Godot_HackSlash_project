extends PlayerState

@onready var sprite: Sprite2D = %Sprite

var hit_source_pos: Vector2
var knock_back_speed := 150
var direction

func enter(context:Dictionary = {}) -> void:
	super()
	animation.play("hurt")
	player.velocity.x = 0
	#player.play_attack_sound()
	
	hit_source_pos = context.get("pos",null)
	if hit_source_pos == null:
		print_debug("Error: can't identify hit source")
	direction = signf(player.global_position.x - hit_source_pos.x)
	sprite.scale.x = -direction
	print_debug("entering HURT state")

func exit() -> void:
	super()
	pass

func frame_update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	# Physic logic
	#var direction := Input.get_axis("left", "right")
	#player.velocity.x = move_toward(player.velocity.x, player.SPEED * direction, player.ACCELERATION * delta)
	var direction := signf(player.global_position.x - hit_source_pos.x)
	if direction == 0:
		direction = 1
	player.velocity.x = move_toward(player.velocity.x, knock_back_speed * direction, player.ACCELERATION * delta)
	

	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	
	# Transition logic



func on_player_event(event: String) :
	match event:
		_:
			pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print_debug("Hurt Animation Finished")
	var direction := Input.get_axis("left", "right")
	if player.is_on_floor(): 
		if direction: 
			Transition.emit(self,"running")
		else: 
			Transition.emit(self,"idling")
	else:
		Transition.emit(self,"falling")
