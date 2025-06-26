class_name CharacterAnimationPlayer
extends AnimationPlayer


@export var sprite : Sprite2D

## flip the sprite, pass 1 if facing right, -1 if facing left
func flip_sprite (dir: int):
	match dir:
		1:
			sprite.flip_h = false
		-1:
			sprite.flip_h = true
		0:
			pass
		_:
			print_debug("flip_sprite error: passing an argument that's neither 1 nor -1 : " + str(dir))
