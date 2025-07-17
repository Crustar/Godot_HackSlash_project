extends PlayerState

# State: dashing
# behavior:
#	play the dashing animation
#	lock the character's moving direction
#	launches the character horizontally
#	follow passive physic (gravity)
# trasition:
#	dash duration timer finishes -> falling/idling/running
#	player presses jump and character can jump -> jumping
#	TODO: allow character to double dash
#	TODO: dash attack
#	character is hit by an enemy -> delegate to character's reveive_hit signal (to hurt state)

var dash_direction = 0
var base_velocity = 0
@onready var dash_duration: Timer = $dash_duration
@onready var sprite: Sprite2D = %Sprite


func enter(context:Dictionary = {}) -> void:
	super()
	base_velocity = abs(player.velocity.x)
	dash_direction = sign(Input.get_axis("left", "right"))
	if dash_direction == 0: # fallback
		dash_direction = sprite.scale.x
			
	dash_duration.start()
	animation.play("dashing")
	AudioController.play_sound("Dash")
	#print_debug("entering DASHING state")

func exit() -> void:
	super()
	player.velocity.x = 0
	pass
	
func frame_update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	# Physic logic
	player.velocity.x = move_toward(player.velocity.x, (player.DASH_SPEED + base_velocity) * dash_direction, player.ACCELERATION * 10 * delta)
		
	player.velocity += player.get_gravity() * delta	
	player.move_and_slide()
	
	
	# Transition logic


func on_player_event(event: String) :
	match event:
		"jump":
			if player.jump_count <= player.max_jump:
				player.velocity.y = - player.JUMP_VELOCITY
				player.jump_count += 1
			Transition.emit(self,"jumping")
		_:
			pass


func _on_dash_cooldown_timeout() -> void:
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
