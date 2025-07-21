extends PlayerState

# State: hurt
# behavior:
#	play the hurt animation 
#	locks character's movement (knockback)
#	follow passive physic (gravity)
# trasition:
#	knockback finishes:
#		character is dead -> dead
#		character is alive -> idle/falling/running
#	

@onready var sprite: Sprite2D = %Sprite

var hit_source_pos: Vector2
var knock_back_speed := 150
var knock_back_power : float
var direction

func enter(context:Dictionary = {}) -> void:
	super()
	
	player.velocity.x = 0
	hit_source_pos = context.get("pos",null)
	knock_back_power = context.get("knock_back_power",-1)
	if hit_source_pos == null:
		print_debug("Error: can't identify hit source's position")
	if knock_back_power == -1:
		print_debug("Error: can't identify hit source's power")
	direction = signf(player.global_position.x - hit_source_pos.x)
	sprite.scale.x = -direction
	player.invulnerable = true
	
	animation.play("hurt")
	Ui.blink_heart()
	#print_debug("entering HURT state")

func exit() -> void:
	super()

func frame_update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	# Physic logic
	#var direction := Input.get_axis("left", "right")
	#player.velocity.x = move_toward(player.velocity.x, player.SPEED * direction, player.ACCELERATION * delta)
	var direction := signf(player.global_position.x - hit_source_pos.x)
	if direction == 0:
		direction = 1
	player.velocity.x = move_toward(player.velocity.x, knock_back_speed * direction * knock_back_power, player.ACCELERATION * delta)
	

	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
	
	
	# Transition logic



func on_player_event(event: String) :
	match event:
		_:
			pass


func on_animation_finished(anim_name: StringName) -> void:
	if player.is_dead:
		Transition.emit(self,"dead")
	else:
		player.invulnerable = false
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
