extends RigidBody2D

@export var start_x: int = 0
@export var end_x: int = 0 
@export var speed: int = 0 
var direction: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = start_x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x >= end_x:
		direction = -1
	elif position.x <= start_x:
		direction = 1
		
	linear_velocity.x = speed * direction 
	move_and_collide(linear_velocity)
