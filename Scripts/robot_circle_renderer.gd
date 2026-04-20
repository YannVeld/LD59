class_name RoboCircleAnimation extends Node2D

const SIGNALSPEED = 120.
const EXIST_TIME = 0.15

var _radius: float = 0
var _alpha: float = 0.0
var _is_animating: bool = false

var _time_since_start: float = 0.0

func play_circle_animation() -> void:
	_is_animating = true
	_radius = 0
	_alpha = 1.0
	_time_since_start = 0.0

func _do_animation(delta: float):
	if not _is_animating: return
	
	_time_since_start += delta
	_radius += SIGNALSPEED*delta
	_alpha = lerpf(1.0, 0.0, _time_since_start/EXIST_TIME)
	queue_redraw()
	
	if _time_since_start >= EXIST_TIME:
		_is_animating = false
		_radius = 0.0
		_alpha = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_do_animation(delta)
	
func _draw() -> void:
	var _col: Color = Color("449489")
	_col.a = _alpha
	draw_circle(position, _radius, _col, false, 2.0)
