extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false
var SPEED = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('enemies')
	add_to_group('destroy')
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
