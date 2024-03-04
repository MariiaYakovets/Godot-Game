extends CharacterBody2D

@export var new_position_x : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_2d_body_entered(body):
	pass


func _on_area_2d_body_exited(body):
	await get_tree().create_timer(5).timeout
	self.position.x = new_position_x 
