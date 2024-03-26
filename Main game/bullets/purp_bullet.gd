extends RigidBody2D
@export var speed : int 
@export var damage : int 
var velocity : Vector2 = Vector2(0,0)
var direction: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = speed * direction
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
	
	var collision_object = move_and_collide(velocity)
	if collision_object :
		var collision_body : Object = collision_object.get_collider()
		if collision_body.is_in_group('Enemies'):
			damage_enemy(collision_body)
		elif not collision_body.is_in_group('Enemies'):
			queue_free()

func damage_enemy(body):
	body.reduce_hp(damage)
	queue_free()
