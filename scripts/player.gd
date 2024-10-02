extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var ray_cast_ladder = $RayCastLadder
@onready var animated_sprite = $AnimatedSprite2D

# 是否在梯子上
var on_ladder: bool = false
# 梯子水平速度
const climb_speed_h = SPEED * 4/5
# 梯子锤子速度
const climb_speed_v = SPEED / 2

func _physics_process(delta):
	
	if on_ladder:
		_ladder_climb(delta)
	else:
		_idle_and_move(delta)
		
	move_and_slide()

# 常规
func _idle_and_move(delta):
		# Add the gravity.
	if not is_on_floor() and !on_ladder:
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

# 爬梯子
func _ladder_climb(_delta):
	#print("_ladder_climb")
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * climb_speed_h
	else:
		velocity.x = move_toward(velocity.x, 0, climb_speed_h)
		 
	if Input.is_action_pressed("move_down"):
		velocity.y = climb_speed_v
	elif Input.is_action_pressed("move_up"):
		velocity.y = -climb_speed_v
	else:
		velocity.y = 0
		
func _on_ladder_body_entered(body):
	print(body.name)
	if body.name == 'Player':
		print("进入梯子区域")
		on_ladder = true

func _on_ladder_body_exited(body):
	if body.name == 'Player':
		print("跳出梯子区域")
		on_ladder = false
