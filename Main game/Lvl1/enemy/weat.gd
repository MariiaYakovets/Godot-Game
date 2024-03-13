extends RigidBody2D

@export var start_x = 0
@export var end_x = 0
@export var speed = 0

var direction
var animation_enemy
# Called when the node enters the scene tree for the first time.
func _ready():
	var start_pos = Vector2()
	start_pos.x = start_x
	start_pos.y = position.y
	position = start_pos
	animation_enemy = get_node("AnimationPlayer")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_enemy.play('walk')
	
	if start_x > end_x:
		direction = -1
	elif start_x < end_x:
		direction = 1
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
	
	if position.x > end_x - 10 and position.x < end_x + 10:
		var tmp = start_x
		start_x = end_x
		end_x = tmp
	linear_velocity.x = direction * speed
	move_and_collide(linear_velocity)
