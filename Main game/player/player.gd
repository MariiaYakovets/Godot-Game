extends CharacterBody2D
#class_name Player
#signal healthChanged
@onready var HPbar = $CanvasLayer/TextureProgressBar
const SPEED = 120.0
const JUMP_VELOCITY = -300.0
var jump_multiplier : float = 1
var move_multiplier : float = 1
@export var maxHealth = 100
@onready var currentHealth: int = maxHealth
var isHurt : bool = false
@export var purple_bullet : PackedScene 
@export var yellow_bullet : PackedScene 
var face : bool = true
var direction
var flag_jump: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_player
var button_bullet = 'yellow'
var current_bullet 
@onready var camera: Camera2D = get_node('Camera2D')

func _ready():
	animation_player = get_node("AnimationPlayer")
	current_bullet = yellow_bullet
	if get_parent().name == 'level3_1':
		camera.limit_bottom = 1100
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if position.y > 1500:
			get_tree().change_scene_to_file("res://Main game/main screen/main_game_screen.tscn")
	#print($Timer.time_left)
	if Input.is_action_just_pressed("D"):
		shoot()
	# Handle jump
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#direction = Input.get_axis("ui_left", "ui_right")
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
			if not animation_player.current_animation == "shoot":
				animation_player.play("idle")
			move_multiplier = 1
	if velocity.y > 0:
		animation_player.play("fall")
	
	if Input.is_action_just_pressed("ui_accept"):
		flag_jump = true
	if flag_jump and is_on_floor():
		animation_player.play("jump")
		velocity.y = JUMP_VELOCITY * jump_multiplier
		flag_jump= false
	move_and_slide()
	
	
	
func hurt_by_enemy(area):
	currentHealth -=10
	isHurt = true 
	#healthChanges.emit()
	
func reduce_hp(hp: int):
	#print($Timer.time_left)
	if $Timer.time_left == 0:
		$Timer.start(0.4)
		#if body.is_in_group('Enemies'):
		currentHealth -= hp
		#if body.is_in_group("Food"):
			#currentHealth += hp_score
		HPbar.value = currentHealth
		if currentHealth <= 0:
			get_tree().change_scene_to_file("res://Main game/main screen/game_over.tscn")
	
func increase_hp(hp: int):
	if currentHealth + hp <= 100:
		currentHealth += hp
		HPbar.value = currentHealth
		
func shoot():
	animation_player.play("shoot")
	#creating an instance of bullet from the pack scene
	var bullet = current_bullet.instantiate()
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

func get_data_to_save():
	var data = {
		'currentHealth': currentHealth,
		'level': get_parent().name,
		'position': self.position
	}
	return data

func load_data_from_save(data: Dictionary):
	currentHealth = data.currentHealth
	position = data.position

func _on_child_entered_tree(node):
	if node.is_in_group('Food'):
		currentHealth += node.hp_cost
		
func _on_menu_pressed():
	get_tree().paused = true
	$"CanvasLayer/Pause menu".visible = true
	
func _on_right_pressed():
	direction = 1
	
func _on_right_released():
	direction = 0

func _on_left_pressed():
	direction = -1

func _on_left_released():
	direction = 0

func _on_fire_pressed():
	shoot()

func _on_fire_released():
	pass # Replace with function body.

func _on_jump_pressed():
	flag_jump = true

func _on_jump_released():
	pass # Replace with function body.

func _on_change_bullet_pressed():
	if button_bullet == 'yellow':
		button_bullet = 'purple'
		current_bullet = purple_bullet
	elif button_bullet == 'purple':
		button_bullet = 'yellow'
		current_bullet = yellow_bullet
	$CanvasLayer/changeBullet/AnimatedSprite2D2.play(button_bullet)


