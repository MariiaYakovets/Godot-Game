extends CharacterBody2D
var flag_chase = false
var direction : int = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var distance : int
@export var patrol_speed: int
@export var chase_speed: int
@export var damage : int
var end_x
var start_x
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('Enemies')
	player = get_parent().get_node('CharacterBody2D')
	start_x = self.position.x - distance/2
	end_x = self.position.x + distance/2
	#player = get_node("Player/Player")
	#print(start_x)
	#print(end_x)
	#print(self.position.x)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if direction == -1:
		$AnimatedSprite2D.flip_h = false
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
	if flag_chase:
		chase()
	else:
		patrol()
	#number of collisions
	var collision_count = get_slide_collision_count()
	#itterate  number of collisions
	for i in collision_count:
		#get_slide_collision returns 2D collision object
		var collision_object : KinematicCollision2D = get_slide_collision(i)
	#gettin the body of a collided object
		var collision_body : Object = collision_object.get_collider() 
		#if the body is a player - do damage
		if collision_body.is_in_group('player'):
			collision_body.update_hp(damage)
	move_and_slide()
	#print(self.position.x)

func chase():
	if self.position.x >= player.position.x:
		direction = -1
	elif self.position.x <= player.position.x:
		direction = 1
	velocity.x = chase_speed * direction 
	#print(flag_chase)
	
func patrol():
	if self.position.x <= start_x:
		direction = 1
	if self.position.x >= end_x:
		direction = -1
	velocity.x = patrol_speed * direction
	#print(flag_chase)

func _on_player_detection_body_entered(body):
	if not body.is_in_group('player'):
		return
	flag_chase = true
	
	if self.position.x >= player.position.x:
		direction = -1
	elif self.position.x <= player.position.x:
		direction = 1

func _on_player_detection_body_exited(body):
	if flag_chase == true:
		if body.is_in_group('player'):
			flag_chase = false