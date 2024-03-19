extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_button_1_pressed():
	get_tree().change_scene_to_file("res://Main game/main screen/main_game_screen.tscn")
	

func _on_rock_button_2_pressed():
	get_tree().change_scene_to_file("res://Main game/main screen/main_game_screen.tscn")



func _on_rock_button_3_pressed():
	get_tree().change_scene_to_file("res://Main game/main screen/main_game_screen.tscn")

