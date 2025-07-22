extends EnemyState

@onready var attack_cd: Timer = $attack_CD

func _ready() -> void:
	attack_cd.timeout.connect(on_attack_CD_timeout)

func enter(context:Dictionary = {}) -> void:
	super()
	enemy.velocity.x = 0
	animation.play("attacking")




func exit() -> void:
	super()
	attack_cd.start()
	enemy.is_in_attack_cd = true



func frame_update(delta: float) -> void:
	pass



func physics_update(delta: float) -> void:	
	enemy.velocity += enemy.get_gravity() * delta	
	enemy.move_and_slide()



func on_got_hit(context: Dictionary):
	super(context)

func on_target_found():
	super()

func on_target_lost():
	pass

func on_animation_finished(anim_name: StringName):
	Transition.emit(self,"chasing")



func on_attack_CD_timeout():
	enemy.is_in_attack_cd = false
