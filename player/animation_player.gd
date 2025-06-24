extends AnimationPlayer

@export var sprite : Sprite2D

## flip the sprite, pass 1 if facing right, -1 if facing left
func flip_sprite (dir: int):
	if dir == 1:
		sprite.flip_h = false
	elif dir == -1:
		sprite.flip_h = true
	else:
		print_debug("flip_sprite error: passing an argument that's neither 1 nor -1 : " + str(dir))
