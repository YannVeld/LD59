extends Node2D

@onready var _my_animator: AnimatedSprite2D = get_node("./AnimatedSprite2D")
@onready var _my_shadow_animator: AnimatedSprite2D = get_node("./ShadowSprite")
@onready var sound_player: SoundPlayer = $SoundPlayer

@onready var _robot = get_node("../Robot")
@onready var _landing_zone = get_node("../LandingZone")

const START_Y: float = -16.0
const INIT_FALL_SPEED: float = 80.0
const MIN_FALL_SPEED: float = 1.0
const DECELERATION: float = 16.0

const READY_LEGS_DIST: float = 16.0

const ROTATION_ANGLE: float = 10.0
const ROTATION_SPEED: float = 1.0

var _speed: float = INIT_FALL_SPEED
var _initial_rotation: float

var is_on_last_frame: bool:
	get: return _my_animator.frame >= _my_animator.sprite_frames.get_frame_count("default") - 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(_robot.position.x, START_Y)
	_robot.set_process(false)
	_robot.visible = false
	_initial_rotation = _my_animator.rotation
	
	_landing_zone.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position.y += _speed * delta
	if position.y >= _robot.position.y:
		position.y = _robot.position.y
		
	_my_shadow_animator.global_position = _robot.global_position
		
	var _t: float = 0.5*(1.0 + cos(2.0 * PI * ROTATION_SPEED * Time.get_ticks_msec()/1000.0))
	_my_animator.rotation_degrees = _initial_rotation + lerpf(-ROTATION_ANGLE,ROTATION_ANGLE, _t)
		
	_speed -= DECELERATION * delta
	_speed = clampf(_speed, MIN_FALL_SPEED, INIT_FALL_SPEED)
	
	var _dist = abs(position.y - _robot.position.y)
	if (_dist < READY_LEGS_DIST) and not is_on_last_frame:
		_my_animator.play()
		_my_shadow_animator.play()
	
	if _dist <= 0.0:
		_robot.set_process(true)
		_robot.visible = true
		_landing_zone.visible = true
		sound_player.play_sound(SoundPlayer.Sounds.ROBOT_LAND, false, 0.0, true)
		queue_free()
