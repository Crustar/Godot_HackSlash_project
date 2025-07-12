extends EnemyState

func enter(context:Dictionary = {}) -> void:
	super()
	enemy.velocity.x = 0
	enemy.toggle_collision(false)
	enemy.toggle_attack(false)
	animation.play("dead")



func exit() -> void:
	super()
	pass

func frame_update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	pass



func on_player_event(event: String) :
	match event:
		_:
			pass


func on_animation_finished(anim_name: StringName) -> void:
	enemy.death_occurred.emit()
