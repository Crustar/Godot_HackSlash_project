extends Node2D

@export var tracking_range: int

@onready var tracking_area: Area2D = $TrackingRange
@onready var tracking_ray: RayCast2D = $TrackingRay

var is_tracking: bool = false

signal target_found
signal target_lost


# =============== built-in notif ===============
func _ready() -> void:
	tracking_area.player_in_range.connect(on_player_in_range)
	tracking_area.player_left_range.connect(on_player_left_range)
	tracking_ray.target_found.connect(on_target_in_sight)
	tracking_ray.target_lost.connect(on_target_left_sight)
	
	tracking_area.set_radius(tracking_range)


# ================ local method ================
func get_chase_data () -> Vector2:
	return tracking_ray.get_chase_data()

# ================ signal method ================
func on_player_in_range (body: Node2D):
	tracking_ray.enable(body as CharacterBody2D)

func on_player_left_range():
	tracking_ray.disable()

func on_target_in_sight():
	self.target_found.emit()

func on_target_left_sight():
	self.target_lost.emit()
