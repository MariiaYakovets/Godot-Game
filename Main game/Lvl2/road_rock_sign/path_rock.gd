extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_read_pressed():
	get_tree().change_scene_to_file("res://Main game/Lvl2/road_rock_sing/choose_rock_scene.tscn")
