extends CharacterBody2D

var flag_chase = false
var direction : int = -1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var chase_speed: int
@export var damage : int
@onready var player = get_parent().get_node('CharacterBody2D')
@export var hp : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if direction == -1:
		$AnimatedSprite2D.flip_h = false
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
	if flag_chase:
		chase()
		
	var collision_count = get_slide_collision_count()
	#itterate  number of collisions
	for i in collision_count:
		#get_slide_collision returns 2D collision object
		var collision_object : KinematicCollision2D = get_slide_collision(i)
	#gettin the body of a collided object
		var collision_body : Object = collision_object.get_collider() 
		#if the body is a player - do damage
		print(collision_body)
		if collision_body:
			if collision_body.is_in_group('player'):
				collision_body.update_hp(damage)
				
	if not flag_chase :
		$AnimatedSprite2D.play('jump')
	else:
		$AnimatedSprite2D.play('run')
	move_and_slide()
	
	
func chase():
	if self.position.x >= player.position.x:
		direction = -1
	elif self.position.x <= player.position.x:
		direction = 1
	velocity.x = chase_speed * direction

func _on_damage_body_entered(body):
	if body.is_in_group('player'):
		flag_chase = true

func _on_chase_body_entered(body):
	if not body.is_in_group('player'):
		return
	flag_chase = true
	chase()
