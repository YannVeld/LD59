extends Node2D

const SPEED = 25.0
var direction = 'right'

func _process(delta: float) -> void:
		
	if direction == 'up':
		position.y += -SPEED*delta
	if direction == 'down':
		position.y += SPEED*delta
	if direction == 'right':
		position.x += SPEED*delta
	if direction == 'left':
		position.x += -SPEED*delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	direction = area.instruction

func _on_area_2d_body_entered(body: Node2D) -> void:
	if direction=='up': direction='down' 
	elif direction=='down': direction='up'
	elif direction=='left': direction='right' 
	elif direction=='right': direction='left' 
