extends Area2D

@onready var tracking_sphere: CollisionShape2D = $trackingSphere


signal player_in_range
signal player_left_range


# =============== built-in notif ===============
func _ready() -> void:
	body_entered.connect(on_character_body_entered)
	body_exited.connect(on_character_body_exited)


# ================ local method ================
func set_radius (radius: int):
	tracking_sphere.shape.radius = radius


# ================ signal method ================
func on_character_body_entered (body: Node2D):
	if body.is_in_group("Player_body"):
		player_in_range.emit(body)

func on_character_body_exited (body: Node2D):
	if body.is_in_group("Player_body"):
		player_left_range.emit()
