extends Node2D

const SPEED = 25.0
const LENGTH_RAYCAST = 8.
var direction = 'null'
signal item_collected

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		if direction=='up': 
			direction='down'
		elif direction=='down': 
			direction='up'
		elif direction=='left': 
			direction='right'
		elif direction=='right': 
			direction='left'
		
	if direction == 'up':
		position.y += -SPEED*delta
		ray_cast_2d.target_position = Vector2(0,-1)*LENGTH_RAYCAST*0.5
	if direction == 'down':
		position.y += SPEED*delta
		ray_cast_2d.target_position = Vector2(0,1)*LENGTH_RAYCAST*0.5
	if direction == 'right':
		position.x += SPEED*delta
		animated_sprite_2d.flip_h = true
		ray_cast_2d.target_position = Vector2(1,0)*LENGTH_RAYCAST
	if direction == 'left':
		position.x += -SPEED*delta
		animated_sprite_2d.flip_h = false
		ray_cast_2d.target_position = Vector2(-1,0)*LENGTH_RAYCAST
	
func _on_area_2d_for_reception_area_entered(area: Area2D) -> void:
	if area.is_in_group("Signal Packets"):
		direction = area.instruction
	if area.is_in_group("Collectibles"):
		print("Collected ", area.name)
		item_collected.emit(area.name)
	
