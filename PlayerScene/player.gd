extends CharacterBody2D


@export var speed : float = 300.0
@export var jump_velocity : float = -360.0
@export var double_jump_velocity : float = -210.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var attacked : bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:	
		has_double_jumped = false
		if was_in_air == true:
			land()
		was_in_air = false 


	# Handle Attack
#	if Input.is_action_just_pressed("attack"):
#		if attacked == false:
#			animation_locked = true
#			animated_sprite.play("attack")
#			attacked = true
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Normal Jump From Floor
			jump()
		elif not has_double_jumped:
			# Double jump in air 
			velocity.y += double_jump_velocity
			has_double_jumped = true
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif  direction.x < 0: 
		animated_sprite.flip_h = true
		
func jump():
	velocity.y = jump_velocity
	animated_sprite.play("jump")
	animation_locked = true
	
func land():
	animated_sprite.play("idle")
	animation_locked = false
	
func attack():
	animated_sprite.play("attack")
	animation_locked = false


func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == 'idle'):
		animation_locked = false
		
func GetCoin():
	Global.coins+=1
	
func die():
	Global.coins = 0
	get_tree().reload_current_scene()


func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://Prefabs/main_menu.tscn")
