extends Sprite2D


func flip_scale (dir: int):
	if dir == -1 or dir == 1:
		self.scale.x = dir
	else:
		print_debug("flip_scale passing wrong arguement")
