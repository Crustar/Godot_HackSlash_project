extends Sprite2D

@onready var dash_ve: CPUParticles2D = %dash_VE
@onready var jump_ve: CPUParticles2D = %jump_VE

func flip_scale (dir: int):
	if dir == -1 or dir == 1:
		self.scale.x = dir
		jump_ve.scale.x = dir
		dash_ve.scale.x = dir
		dash_ve.gravity.x = -abs(dash_ve.gravity.x) * dir
	else:
		print_debug("flip_scale passing wrong arguement")
