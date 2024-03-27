extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
@export var hp: int
@onready var HPbar = $TextureProgressBar 
@export var damage: int

# Called when the node enters the scene tree for the first time.
func _ready():
	HPbar.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide()
	var collision_count = get_slide_collision_count()
	#itterate  number of collisions
	for i in collision_count:
		#get_slide_collision returns 2D collision object
		var collision_object : KinematicCollision2D = get_slide_collision(i)
	#gettin the body of a collided object
		var collision_body : Object = collision_object.get_collider() 
		#if the body is a player - do damage
		if collision_body:
			if collision_body.is_in_group('player'):
				collision_body.reduce_hp(damage)
func reduce_hp(damage):
	hp -= damage
	HPbar.value = hp
	if hp <= 0:
		queue_free()

func _on_damage_body_entered(body):
	if body.is_in_group('player'):
		HPbar.visible = true
		

func _on_damage_body_exited(body):
	if body.is_in_group('player'):
		HPbar.visible = false
