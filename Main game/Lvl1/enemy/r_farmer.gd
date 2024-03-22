extends RigidBody2D
@onready var timer = get_node("Timer")
@export var hp : int
@export var damage : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_damage_body_entered(body):
	if body.is_in_group('player'):
		body.update_hp(2)


func _on_kill_emeny_body_entered(body):
	if body.is_in_group('Bullets'):
		hp -= body.damage
	#	await get_node("AnimationPlayer").animation_finished
	if hp <= 0:
		$AnimationPlayer.play('blink')
		timer.start(1)
		

func _on_timer_timeout():
	queue_free()
