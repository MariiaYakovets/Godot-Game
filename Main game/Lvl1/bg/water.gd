extends Area2D

@onready var anim = get_node("AnimatedSprite2D")
func _physics_process(delta):
	anim.play("basic")
