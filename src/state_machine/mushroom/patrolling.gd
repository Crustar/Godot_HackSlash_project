extends EnemyState

@onready var sprite: Sprite2D = %Sprite
@onready var ray_cast_down: RayCast2D = %RayCastDown

@onready var patrol_timer: Timer = $PatrolTimer
var patrol_time_array = [2.0, 2.5, 4.0]
var left_or_right = [-1, 1]
var direction : int


func enter(context:Dictionary = {}) -> void:
	super()
	
	patrol_timer.start(patrol_time_array.pick_random())
	direction  = left_or_right.pick_random()
	sprite.flip_scale(direction)
	
	animation.play("running")



func exit() -> void:
	super()



func frame_update(delta: float) -> void:
	if enemy.is_on_wall() or !ray_cast_down.is_colliding():
		direction *= -1
		sprite.flip_scale(direction)



func physics_update(delta: float) -> void:
	enemy.velocity.x = move_toward(enemy.velocity.x, enemy.PATROL_SPEED * direction, enemy.ACCELERATION * delta)
	
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()



func on_got_hit(context: Dictionary):
	super(context)



func on_animation_finished(anim_name: StringName):
	pass



func _on_patrol_timer_timeout() -> void:
	Transition.emit(self,"idling")
