extends Sprite2D

const initial_angle = PI/4
var last_input_device = "keyboard_mouse"
var _rel_mouse_pos = Vector2.RIGHT

func _input(event) -> void:
	if (event is InputEventJoypadButton) or (event is InputEventJoypadMotion):
		last_input_device = "controller"
	elif (event is InputEventMouseMotion) \
		or (event is InputEventMouseButton) \
		or (event is InputEventKey):
		last_input_device = "keyboard_mouse"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if last_input_device == "controller":
		var _inp = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down").normalized()
		if _inp.length() > 0:
			_rel_mouse_pos = _inp
	else:
		_rel_mouse_pos = get_global_mouse_position() - global_position
	
	var _angle = _rel_mouse_pos.angle()
	rotation = _angle + initial_angle
