extends CharacterBody2D

@export var start_x = 0
@export var end_x = 0
@export var speed_podkradulka: int = 0
var speed = 0
var direction = 0
var animation_enemy
var player
@export var hp: int
@onready var HPbar = $TextureProgressBar 
@export var damage: int 


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_enemy = get_node("AnimatedSprite2D")
	HPbar.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):	
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false
	if player:
		if player.position.x > self.position.x:
				direction = 1
		elif player.position.x <= self.position.x:
			direction = -1
	velocity.x = direction * speed
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

func _on_podkradulka_body_entered(body):
	if body.is_in_group('player'):
		animation_enemy.play("walk")
		speed = speed_podkradulka
		player = body
		HPbar.visible = false		

func _on_podkradulka_body_exited(body):
	if body.is_in_group('player'):
		animation_enemy.play('sit')
		speed = 0
		player = null
		HPbar.visible = false
	
func _on_attack_body_entered(body):
	if body.is_in_group('player'):
		animation_enemy.play('attack')
		speed = 0
		player = body
		HPbar.visible = true

func _on_attack_body_exited(body):
	if body.is_in_group('player'):
		animation_enemy.play('walk')
		speed = speed_podkradulka
		player = null
		HPbar.visible = false
		


