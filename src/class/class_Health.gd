class_name Health extends Node

@export var body: CharacterBody2D
var health : float = 0

func _ready() -> void: 
	for child in body.get_children():
		if child is Sprite2D :
			for grandchild in child.get_children():
				if grandchild is HurtBox:
					## grandchild = each node under the path "$body/Sprite" that is a Hurtbox
					health += grandchild.health
					grandchild.area_entered.connect(_on_hurtbox_area_entered)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if ((body.is_in_group("Enemy_body") and area.is_in_group("Character_hit_box")) or (body.is_in_group("Player_body") and area.is_in_group("Enemy_hit_box"))) and !body.invulnerable:
		## if a character hits a enemy or an enemy hits a character, and the object being hit is not invulnerable
		var target_area = area as HitBox # casting to retrieve the damage value
		damage_taken(area.damage)
		body.receive_hit.emit({"pos":target_area.global_position,"knock_back_power":target_area.knock_back_power})


func damage_taken (dmg: float):
	health -= dmg
	if health <= 0:
		body.is_dead = true
