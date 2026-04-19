extends Node2D

const SPEED = 25.0
const LENGTH_RAYCAST = 8.
var direction = 'null'
signal item_collected
signal landing_zone_entered

@export var item_icons: Dictionary[String, Texture2D] = {'fruit'=null, 'mushroom'=null, 'vine'=null}

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var item_pickup_particle: CPUParticles2D = $ItemPickupParticle
@onready var particle_timer: Timer = $ParticleTimer

var time_since_collision: float = 999.0
var last_item_collected: String = ""
const COLL_TIME_IDLE: float = 0.2

var is_on_last_frame: bool:
	get: return animated_sprite_2d.frame >= animated_sprite_2d.sprite_frames.get_frame_count(animated_sprite_2d.animation) - 1

var is_jumping: bool:
	get: return (animated_sprite_2d.animation == "jump") and (not is_on_last_frame)

func _update_animation(dir: String) -> void:
	if dir == 'null':
		animated_sprite_2d.set_animation('idle')
		return
		
	if is_jumping:
		return
		
	animated_sprite_2d.set_animation('walk')

func _play_item_collect_particle(name: String) -> void:
	item_pickup_particle.texture = item_icons[name]
	item_pickup_particle.emitting = true

func _collect_item(item: Collectable) -> void:
	print("Collected ", item.item_name)
	print(item.turn_off_shader())
	item_collected.emit(item.name)
	animated_sprite_2d.set_animation('jump')
	last_item_collected = item.item_name
	particle_timer.start()
	item.already_collected = true
	

func _get_bounce_direction() -> String:
	if time_since_collision < COLL_TIME_IDLE:
		return 'null'
	
	if direction=='up': 
		return 'down'
	elif direction=='down': 
		return 'up'
	elif direction=='left': 
		return 'right'
	elif direction=='right': 
		return 'left'
	
	return 'null'

func _process(delta: float) -> void:
	time_since_collision += delta

	if ray_cast_2d.is_colliding():
		direction = _get_bounce_direction()
		time_since_collision = 0.0
		
	var velocity = Vector2.ZERO
	if direction == 'null':
		ray_cast_2d.target_position = Vector2(0,0)
	if direction == 'up':
		velocity.y += -SPEED
		ray_cast_2d.target_position = Vector2(0,-1)*LENGTH_RAYCAST*0.5
	if direction == 'down':
		velocity.y += SPEED
		ray_cast_2d.target_position = Vector2(0,1)*LENGTH_RAYCAST*0.5
	if direction == 'right':
		velocity.x += SPEED
		animated_sprite_2d.flip_h = true
		ray_cast_2d.target_position = Vector2(1,0)*LENGTH_RAYCAST
	if direction == 'left':
		velocity.x += -SPEED
		animated_sprite_2d.flip_h = false
		ray_cast_2d.target_position = Vector2(-1,0)*LENGTH_RAYCAST


	if not is_jumping:
		position += velocity * delta

	_update_animation(direction)
	

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Signal Packets"):
		direction = area.instruction
		time_since_collision = COLL_TIME_IDLE
	if area.is_in_group("Collectibles"):
		if not area.already_collected:
			_collect_item(area)
	if area.name=="LandingZone":
		landing_zone_entered.emit()
	pass # Replace with function body.


func _on_particle_timer_timeout() -> void:
	_play_item_collect_particle(last_item_collected)
	
	
	
