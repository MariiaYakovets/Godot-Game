extends CanvasLayer

func _on_you_failed_pressed() -> void:
	get_tree().change_scene_to_file()
	
func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file()


func _on_timer_timeout() -> void:
	_on_you_died_pressed()
