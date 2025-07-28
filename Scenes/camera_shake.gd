extends Camera2D

var shake_timer := 0.0
var shake_intensity := 0.0

func shake(intensity: float = 4.0, duration: float = 0.15):
	shake_intensity = intensity
	shake_timer = duration

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if shake_timer > 0:
		shake_timer -= delta
		offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
	else:
		offset = Vector2.ZERO

func set_camera_limit(marker_pos_1: Vector2, marker_pos_2: Vector2) -> void:
	self.limit_left = min(marker_pos_1.x , marker_pos_2.x)
	self.limit_top = min(marker_pos_1.y, marker_pos_2.y)
	self.limit_right = max(marker_pos_1.x, marker_pos_2.x)
	self.limit_bottom = max(marker_pos_1.y, marker_pos_2.y)
