extends Health

#@export var player: CharacterBody2D

func _ready() -> void:
	super()

func damage_taken (dmg: float):
	super(dmg)
	print_debug("current health = "+str(health))
	if health <= 0:
		body.is_dead = true
