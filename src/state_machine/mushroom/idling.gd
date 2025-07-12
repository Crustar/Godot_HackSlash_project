extends EnemyState

@onready var idle_timer: Timer = $IdleTimer
var idle_time_array = [2.0, 2.5, 4.0]

func enter(context:Dictionary = {}) -> void:
	super()
	animation.play("idling")
	idle_timer.start(randome_time())

func randome_time():
	idle_time_array.shuffle()
	return idle_time_array.front()



func exit() -> void:
	super()



func frame_update(delta: float) -> void:
	pass



func physics_update(delta: float) -> void:
	enemy.velocity.x = move_toward(enemy.velocity.x, 0, enemy.FRICTION * delta)
	
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()



func on_got_hit(context: Dictionary):
	super(context)



func on_animation_finished(anim_name: StringName):
	pass



func _on_idle_timer_timeout() -> void:
	Transition.emit(self,"patrolling")
