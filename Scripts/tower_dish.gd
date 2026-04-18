extends Sprite2D

const initial_angle = PI/4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var _rel_mouse_pos = get_global_mouse_position() - global_position
	var _angle = _rel_mouse_pos.angle()
	rotation = _angle + initial_angle
