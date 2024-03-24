extends CharacterBody2D
@export_enum("green_farmer", "fork_farmer", "red_farmer") var farmer_amination: String
@export var hp: int
@export var damage: int = 1
var direction = 1
@onready var player = get_node("../../Player")
var isHurt: bool = false
@onready var bullet = get_node('yellow_bullet')
# Called when the node enters the scene tree for the first time.
func _ready():
	#getting AnimationPlayer node with animations
	var animation_player = get_node("AnimationPlayer")
	#setting autoplay animation property
	animation_player.play(farmer_amination)
	#print(farmer_amination)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if player.position.x > self.position.x:
		direction = 1
	elif player.position.x <= self.position.x:
		direction = -1
	if direction == 1:
		$AnimatedSprite2D.flip_h = true
	elif direction == -1:
		$AnimatedSprite2D.flip_h = false
	
	var collision_object: KinematicCollision2D = move_and_collide(velocity)

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_body = collision.get_collider()
		if not collision_body:
			break
		if collision_body.is_in_group('player'):
			collision_body.update_hp(damage)
	move_and_slide()
func update_hp(hp: int):
	pass


func _on_damage_body_entered(body):
	if body.is_in_group('Bullets'):
		isHurt = true

func damage_from_bullet():
	if isHurt :
		hp -= bullet.damage