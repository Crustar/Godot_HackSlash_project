extends EnemyState

var direction : int
var hit_source_pos: Vector2
var knock_back_speed:= 15.0
var knock_back_power: float
@onready var sprite: Sprite2D = %Sprite


func enter(context:Dictionary = {}) -> void:
	super()
	
	enemy.toggle_attack(false)
	
	enemy.velocity.x = 0
	hit_source_pos = context.get("pos",null)
	knock_back_power = context.get("knock_back_power",-1)
	if hit_source_pos == null:
		print_debug("Error: can't identify hit source's position")
	if knock_back_power == -1:
		print_debug("Error: can't identify hit source's power")
	direction = signf(enemy.global_position.x - hit_source_pos.x)
	sprite.scale.x = -direction
	
	animation.play("hurt")



func exit() -> void:
	super()



func frame_update(delta: float) -> void:
	pass



func physics_update(delta: float) -> void:
	enemy.velocity.x = move_toward(enemy.velocity.x, knock_back_speed * direction * knock_back_power, enemy.ACCELERATION * delta)
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()



func on_got_hit(context: Dictionary):
	super(context)



func on_animation_finished(anim_name: StringName):
	if enemy.is_dead:
		Transition.emit(self,"dead")
	else:
		enemy.toggle_attack(true)
		enemy.invulnerable = false
		Transition.emit(self,"patrolling")
