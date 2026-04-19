extends Node

var keysComplete = false
var mouseComplete = false
@onready var mouseTimer: Timer = $mouseTimer
@onready var keysTimer: Timer = $KeysTimer
var ready_for_tutorial = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KeysSample.hide()
	$MouseSample.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if ready_for_tutorial:
		if event is InputEventMouseMotion and not mouseComplete:
			mouseComplete = true
			mouseTimer.start(1.5)
		if event is InputEventKey and mouseComplete and not keysComplete and mouseTimer.is_stopped():
			keysTimer.start(1.5)
			keysComplete = true
		
func _on_mouse_timer_timeout() -> void:
	$MouseSample.hide()
	$KeysSample.show()

func _on_keys_timer_timeout() -> void:
	$KeysSample.hide()
	queue_free()
	
func _on_tower_landing_landing_animation_finished() -> void:
	ready_for_tutorial = true
	$MouseSample.show()
	pass # Replace with function body.
