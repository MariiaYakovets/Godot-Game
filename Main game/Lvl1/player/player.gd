extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation_player

func _ready():
	animation_player = get_node("AnimationPlayer2")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation_player.play("run")
			print("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y ==0:
			animation_player.play("idle")
			print("idle")
	#if velocity.y > 0:
	#	animation_player.play("fall")
	#	print("fall")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		animation_player.play("jump")
		print("jump")
		velocity.y = JUMP_VELOCITY
	
		
	move_and_slide()
	
	
		