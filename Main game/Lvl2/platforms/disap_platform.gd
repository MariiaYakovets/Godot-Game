extends StaticBody2D
var enter: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_for_pl_body_entered(body):
	if body.is_in_group('player'):
		if enter:
			await get_tree().create_timer(5).timeout
			$AnimationPlayer.play('disap')
			await get_node("AnimationPlayer").animation_finished
			
			queue_free()


func _on_start_disappearing_body_entered(body):
	enter = true
