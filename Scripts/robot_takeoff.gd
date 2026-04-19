class_name RobotTakeoff extends Node2D

@onready var _my_animator: AnimatedSprite2D = get_node("./AnimatedSprite2D")
@onready var _landing_zone = get_node("../LandingZone")

const INIT_FLY_SPEED: float = 5.0
const MAX_FLY_SPEED: float = 500.0
const ACCELERATION: float = 150.0

const START_FLYING_FRAME: int = 6
const OFFSET: Vector2 = Vector2(0.0, -4.0)

var WIGGLE_DIST: float = 0.0
const WIGGLE_SPEED: float = 2.5
const WIGGLE_DIST_CHANGE: float = 1.5

var _speed: float = INIT_FLY_SPEED
var _orig_x: float = 0.0

var _is_flying: bool = false

signal takeoff_complete
signal flying_starts

func start_takeoff():
	position = _landing_zone.position + OFFSET
	
	_orig_x = position.x
	_is_flying = false
	visible = true
	
	_my_animator.play("takeoff")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_my_animator.stop()
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _my_animator.animation == "takeoff" and _my_animator.frame >= START_FLYING_FRAME:
		_is_flying = true
	
	if _is_flying:
		position.y -= _speed * delta
		
		var _t: float = 0.5*(1.0 + cos(2.0 * PI * WIGGLE_SPEED * Time.get_ticks_msec()/1000.0))
		position.x = _orig_x + lerpf(-WIGGLE_DIST,WIGGLE_DIST, _t)
		
		_speed += ACCELERATION * delta
		_speed = clampf(_speed, INIT_FLY_SPEED, MAX_FLY_SPEED)
		
		WIGGLE_DIST += WIGGLE_DIST_CHANGE*delta

	if position.y <= 0.0:
		takeoff_complete.emit()
		

func _on_animated_sprite_2d_animation_finished() -> void:
	_is_flying = true
	_my_animator.play("flying")
	flying_starts.emit()
