class_name Health extends Node

@export var body: CharacterBody2D
var health : float = 0

func _ready() -> void: 
	for child in body.get_children():
		if child is Sprite2D :
			for grandchild in child.get_children():
				if grandchild is HurtBox:
					health += grandchild.health

func damage_taken (dmg: float):
	health -= dmg
