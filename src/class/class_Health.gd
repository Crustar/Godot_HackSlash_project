class_name Health extends Node

@export var body: CharacterBody2D
var health : float = 0

func _ready() -> void: 
	for child in body.get_children():
		if child is Sprite2D :
			for grandchild in child.get_children():
				if grandchild is HurtBox:
					health += grandchild.health
					grandchild.area_entered.connect(_on_hurtbox_area_entered)

func damage_taken (dmg: float):
	health -= dmg
	print_debug("	current health = "+str(health))
	if health <= 0:
		body.is_dead = true

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if ((body.is_in_group("Enemy_body") and area.is_in_group("Character_hit_box")) or (body.is_in_group("Player_body") and area.is_in_group("Enemy_hit_box"))) and !body.invulnerable:
		var target_area = area as HitBox
		damage_taken(area.damage)
		body.receive_hit.emit({"pos":target_area.global_position,"knock_back_power":target_area.knock_back_power})
