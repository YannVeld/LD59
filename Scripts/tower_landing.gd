extends Node2D

@onready var _my_animator: AnimatedSprite2D = get_node("./AnimatedSprite2D")
@onready var _my_particle_emitter: CPUParticles2D = get_node("./CPUParticles2D")

@onready var _transmitter = get_node("../Transmitter")

const START_Y: float = -240.0
const INIT_FALL_SPEED: float = 250.0
const MIN_FALL_SPEED: float = 1.0
const DECELERATION: float = 0.0

const WAIT_AFTER_LANDING: float = 1.0



var _speed: float = INIT_FALL_SPEED
var _has_landed: bool = false
var _time_since_landing: float = 0.0


var is_on_last_frame: bool:
	get: return _my_animator.frame >= _my_animator.sprite_frames.get_frame_count("default") - 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(_transmitter.position.x, START_Y)
	_transmitter.set_process(false)
	_transmitter.visible = false


func _do_fall(delta: float) -> void:
	if _has_landed: return
	
	position.y += _speed * delta
	if position.y >= _transmitter.position.y:
		position.y = _transmitter.position.y
		
	_speed -= DECELERATION * delta
	_speed = clampf(_speed, MIN_FALL_SPEED, INIT_FALL_SPEED)
	
	var _dist = abs(position.y - _transmitter.position.y)
	if _dist <= 0.0:
		_has_landed = true
		_my_animator.set_frame(1)
		_my_particle_emitter.emitting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_do_fall(delta)
	
	if _has_landed:
		_time_since_landing += delta
	
	if (_time_since_landing >= WAIT_AFTER_LANDING) and not is_on_last_frame:
		_my_animator.play()
	
	if is_on_last_frame:
		_transmitter.set_process(true)
		_transmitter.visible = true
		queue_free()
