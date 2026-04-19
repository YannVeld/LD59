extends Node

var keysComplete = false
var mouseComplete = false
@onready var mouseTimer: Timer = $mouseTimer
@onready var keysTimer: Timer = $KeysTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$KeysSample.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and not mouseComplete:
		mouseComplete = true
		mouseTimer.start(3)
	if event is InputEventKey and mouseComplete and not keysComplete and mouseTimer.is_stopped():
		keysTimer.start(2)
		keysComplete = true
		
func _on_mouse_timer_timeout() -> void:
	$MouseSample.hide()
	$KeysSample.show()

func _on_keys_timer_timeout() -> void:
	$KeysSample.hide()
	queue_free()
	
