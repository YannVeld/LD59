extends Node

var keysComplete = false
var mouseComplete = false
@onready var mouseTimer: Timer = $mouseTimer
@onready var keysTimer: Timer = $KeysTimer
var ready_for_tutorial = false
const FADE_IN_DURATION = 1.0
const FADE_OUT_DURATION = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KeysSample.hide()
	$MouseSample.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if ready_for_tutorial:
		if event is InputEventMouseMotion and not mouseComplete:
			mouseComplete = true
			mouseTimer.start(2.5)
		if event is InputEventKey and mouseComplete and not keysComplete and mouseTimer.is_stopped():
			keysTimer.start(2.0)
			keysComplete = true
		
func _on_mouse_timer_timeout() -> void:
	modulate_out($MouseSample, FADE_OUT_DURATION)
	$KeysSample.show()
	modulate_in($KeysSample, FADE_IN_DURATION)

func _on_keys_timer_timeout() -> void:
	modulate_out($KeysSample, FADE_OUT_DURATION)
	$Timer.start(1)
	
func _on_tower_landing_landing_animation_finished() -> void:
	ready_for_tutorial = true
	$MouseSample.show()
	modulate_in($MouseSample, FADE_IN_DURATION)
	pass # Replace with function body.
	
func modulate_in(thing, duration):
	thing.modulate.a = 0
	
	var tween = create_tween()
	tween.tween_property(thing, "modulate:a", 1., duration)
	
func modulate_out(thing, duration):
	thing.modulate.a = 1
	
	var tween = create_tween()
	tween.tween_property(thing, "modulate:a", 0., duration)
	
func _on_timer_timeout() -> void:
	queue_free()
