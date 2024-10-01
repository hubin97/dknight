extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_left = $RayCastLeft
@onready var ray_cast_right = $RayCastRight

const SPEED = 20
var direction = 1

func _process(delta):
	
	if  ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
		
	position.x += direction * SPEED * delta
