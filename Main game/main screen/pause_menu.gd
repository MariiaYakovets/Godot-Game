extends Control
var config = ConfigFile.new()
@onready var player = get_parent().get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	config.load('user://save.cfg')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_save_pressed():
	var data
	#print(player.get_data_to_save())
	#перебрать словарь и записать в конфиг все значения и ключи 
	config.save('user://save.cfg')
	
func _on_resume_pressed():
	get_tree().paused = false
	visible = false

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Main game/main screen/main_game_screen.tscn")
	
	
func _on_quit_pressed():
	get_tree().quit()

