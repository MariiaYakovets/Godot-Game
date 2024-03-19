extends Area2D

@export var x_multiplier: float = 1
@export var y_multiplier: float = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group('player'):
		body.jump_multiplier = y_multiplier
		

func _on_body_exited(body):
	if body.is_in_group('player'):
		body.jump_multiplier = 1
		body.move_multiplier = x_multiplier




