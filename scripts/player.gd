extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var ray_cast_ladder = $RayCastLadder
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	
	if ray_cast_ladder.get_collider():
		_ladder_climb(delta)
	else:
		_idle_and_move(delta)
		
	move_and_slide()

# 正常运动
func _idle_and_move(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true

#爬梯子
func _ladder_climb(_delta):
	print("_ladder_climb")
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("move_left", "move_right")
	direction.y = Input.get_axis("move_up", "move_down")
	
	if direction:
		velocity = direction * SPEED/2 
	else:
		velocity = Vector2.ZERO
	
