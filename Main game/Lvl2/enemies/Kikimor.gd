extends CharacterBody2D
#var chase = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group('enemies')
	add_to_group('destroy')



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_detection_body_entered(body):
	$AnimatedSprite2D.play('Kikimor')
#	chase = true
#	if chase:
#		if self.direction.x >= player.direction.x:
#			$AnimatedSprite2D.flip_h = false
#		elif self.direction.x <= player.direction.x:
#			$AnimatedSprite2D.flip_h = true


#func _on_player_detection_body_exited(body):
#	$AnimatedSprite2D.play('Kikimor')
#	chase = false
