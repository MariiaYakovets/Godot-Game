extends RigidBody2D
@export var speed : int 
@export var damage : int
var velocity : Vector2 = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = speed
	move_and_collide(velocity)
