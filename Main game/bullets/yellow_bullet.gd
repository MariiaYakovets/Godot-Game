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
	move_and_collide(velocity)

func damage_enemy(body):
	if body.is_in_group('Enemies'):
		body.hp -= damage
		print('damage')
		queue_free()
	
	elif not body.is_in_group('Enemies'):
		queue_free()
	print(body)

func _on_damage_area_body_entered(body):
	damage_enemy(body)
