extends ColorRect

@export var FADE_IN_SPEED = 0.5
@export var FADE_OUT_SPEED = 0.7
var fading_in = true
var fading_out = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_in:
		color[3] -= FADE_IN_SPEED*delta
		if color[3]<0:
			color[3]=0
			fading_in=false
		
	if fading_out:
		color[3] += FADE_OUT_SPEED*delta
		
func _on_robot_takeoff_flying_starts() -> void:
	fading_out=true
