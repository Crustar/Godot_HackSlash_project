extends RayCast2D


signal target_found
signal target_lost


var body: CharacterBody2D		# player node, passed as argument when it enters the tracking range
var have_sight: bool = false	# whether or not the ray have line of sight of the player
var last_seen_position: Vector2	# last seen position of the character, or its current location if have sight


# =============== built-in notif ===============
func _physics_process(delta: float) -> void:
	if not enabled or body == null:
		return
	
	track_target(body.global_position)
	if is_colliding():
		var collider = get_collider()
		if collider.is_in_group("Player_body"):
			if not have_sight:
				have_sight = true
				target_found.emit()
			last_seen_position = collider.global_position
		else:
			if have_sight:
				have_sight = false
				target_lost.emit()



# ================ local method ================
func get_chase_data() -> Vector2:
	return last_seen_position

func track_target(target: Vector2):
	target_position = target - global_position + Vector2(0,-1) 
	# edeg effect, the position is on the edge of the shape, add 1 pixel make collide from under possible

func enable(target_body: CharacterBody2D):
	body = target_body
	enabled = true

func disable():
	if have_sight:
		have_sight = false
		target_lost.emit()
	body = null
	enabled = false
