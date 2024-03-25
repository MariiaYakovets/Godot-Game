extends Node
@onready var save_nodes = get_tree().get_nodes_in_group('Persist')
#@onready var player = get_node('Player')
#var position = player.position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func save():
	var save_dict = {
		'filename': get_scene_file_path(),
		'parent': get_parent().get_path(),
		'pos_x': position.x,
		'pos_y': position.y,
		'currentHealth': currentHealth,
		'maxHealth': axHealth,
		'damage': damage,
		'level': level,
		}

func save_game():
	var save_game = FileAccess.open('user://savegame.save', FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group('Persist')
	for node in save_nodes:
		
		#check if node is an instanced scene so it can be instanced again during load
		if node.scene_file_path.is_empty():
			print('no an instant node, skipped' % node.name)
			continue
			
		#check if node has a save function
		if !node.has_method('save'):
			print("persistent node is missing a save() function, skipped" % node.name)
			continue
		#cal the node's save function
		var node_data = node.call('save')
		
		#JSON provides a static method to serialise JSON string
		var json_string = JSON.stringify(node_data)
		
		#store the save sictionary as a new line in the save file
		save_game.store_line(json_string)
	
func load_game():
	if not FileAccess.file_exists('user://savegame.save'):
		return #error, as we don't have a saved node
		
	#deleting sevable object to avoid clonning
	var save_nodes = get_tree().get_first_node_in_group('Persist')
	for i in save_nodes:
		i.queue_free()
		
	#loading file line by line and processing dictionary  to restore the object it reprenets
	var save_game = FileAccess.open('user://savegame.save', FileAccess.READ)
	while save_game.get_position() < save_game().get_length():
		var json_string = save_game().get_line()
		
		#creates a helper class to interact with JSON
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error", json.get_error_message(), "in", json_string, "at line", json.get_error_line())
			continue
			
		var node_data = json.get_data()
		
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i =="pos_x" or i== "pos_y":
				continue
			new_object.set(i, node_data[i])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
