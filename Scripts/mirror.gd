extends StaticBody2D


## In degrees
@export var rotation_speed: float = 0.0
@export var back_and_forth: bool = false
@export_range(0,360) var rotation_max_angle: float = 90.0

var _rot_direction: int = 1
var _orig_rotation: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_orig_rotation = rotation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += rotation_speed * delta * _rot_direction
	
	#while rotation > 2*PI: rotation -= 2*PI
	#while rotation < 0: rotation += 2*PI
	
	if back_and_forth and (abs(rotation - _orig_rotation) >= deg_to_rad(rotation_max_angle)):
		_rot_direction *= -1
