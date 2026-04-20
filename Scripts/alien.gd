class_name Alien extends Area2D

const WANDER_DISTANCE: float = 16
const MIN_TIME_BETWEEN_WANDERING: float = 2.0
const MAX_TIME_BETWEEN_WANDERING: float = 4.0
const SPEED: float = 8.0

const DISTANCE_DELTA: float = 2.0

const JUMP_CHANCE: float = 0.25
const MIN_JUMPS_COUNT: int = 2
const MAX_JUMPS_COUNT: int = 4


var _target_position: Vector2
var _orig_position: Vector2
var _wander_timer: float
var _wander_time: float
var velocity: Vector2 = Vector2.ZERO

var _is_jumping: bool = false
var _jumps_to_go: int = 3

@onready var _my_animator: AnimatedSprite2D = $AnimatedSprite2D

func _get_random_wander_position() -> Vector2:
	var _angle = randf_range(0, 2*PI)
	var _rad = randf_range(0, WANDER_DISTANCE)
	var _vec = Vector2.RIGHT * _rad
	_vec = _vec.rotated(_angle)
	return _orig_position + _vec

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_orig_position = position
	_target_position = position
	_wander_time = randf_range(MIN_TIME_BETWEEN_WANDERING, MAX_TIME_BETWEEN_WANDERING)
	_wander_timer = randf_range(0, MIN_TIME_BETWEEN_WANDERING)

func _make_new_decision() -> void:
	if (randf() <= JUMP_CHANCE) and not _is_jumping:
		_is_jumping = true
		_jumps_to_go = randi_range(MIN_JUMPS_COUNT, MAX_JUMPS_COUNT)
		_my_animator.play("jump")
	
	_wander_timer = 0.0
	_wander_time = randf_range(MIN_TIME_BETWEEN_WANDERING, MAX_TIME_BETWEEN_WANDERING)
	_target_position = _get_random_wander_position()

func _do_wander(delta: float) -> void:
	_wander_timer += delta
	
	var _vec_to_target = _target_position - position
	var _dist_to_target = _vec_to_target.length()
	
	velocity = Vector2.ZERO
	if _dist_to_target >= DISTANCE_DELTA:
		velocity = _vec_to_target.normalized() * SPEED
	
	position += velocity * delta
	
	if velocity.length() <= 0.01:
		_my_animator.play("idle")
	else:
		_my_animator.play("walk")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _wander_timer >= _wander_time:
		_make_new_decision()
	
	if not _is_jumping:
		_do_wander(delta)

func _on_animated_sprite_2d_animation_looped() -> void:
	if _my_animator.animation != "jump": return
	
	_jumps_to_go -= 1
	if _jumps_to_go <= 0:
		_is_jumping = false
