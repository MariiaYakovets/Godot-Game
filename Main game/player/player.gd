extends CharacterBody2D
#class_name Player
#signal healthChanged
@onready var HPbar = $"CanvasLayer/TextureProgressBar"
const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var jump_multiplier : float = 1
var move_multiplier : float = 1
@export var maxHealth = 100
@onready var currentHealth: int = maxHealth
var isHurt : bool = false
@export var purple_bullet : PackedScene 
@export var yellow_bullet : PackedScene 
var face : bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation_player

func _ready():
	animation_player = get_node("AnimationPlayer")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#print($Timer.time_left)
	if Input.is_action_just_pressed("D"):
		shoot()
	# Handle jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
		face = true
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
		face = false
	if direction:
		velocity.x = direction * SPEED * move_multiplier
		if velocity.y == 0:
			animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y ==0:
			animation_player.play("idle")
			move_multiplier = 1
	if velocity.y > 0:
		animation_player.play("fall")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		animation_player.play("jump")
		velocity.y = JUMP_VELOCITY * jump_multiplier
	move_and_slide()
	
	
	
func hurt_by_enemy(area):
	currentHealth -=10
	isHurt = true 
	#healthChanges.emit()
	
func update_hp(hp: int):
	#print($Timer.time_left)
	if $Timer.time_left == 0:
		$Timer.start(0.4)
		currentHealth -= hp
		HPbar.value = currentHealth
		if currentHealth <= 0:
			get_tree().change_scene_to_file("res://Main game/main screen/main_game_screen.tscn")

func shoot():
	#creating an instance of bullet from the pack scene
	var bullet = yellow_bullet.instantiate()
	# face true = to the right
	#give the bullet a position of a marker, direction
	if face :
		bullet.position = $MarkerRight.global_position
		bullet.direction = 1
	else:
		bullet.position = $MarkerLeft.global_position
		bullet.direction = -1
	#adding the bullet to the player scene za lapky
	get_parent().add_child(bullet)


#func _on_menu_pressed():
#	get_tree().change_scene_to_file()


func _on_child_entered_tree(node):
	pass # Replace with function body.
