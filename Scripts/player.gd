#extends CharacterBody2D
#
#const Walk_Speed = 150.0
#const JUMP_VELOCITY = -330.0
#@export var Run_Speed = 250
#@export_range(0,1) var acc = 0.1
#@export_range(0,1) var dec = 0.1
#const PUSH_FORCE = 120.0
#
#@export var max_health := 3
#var current_health := max_health
#
#@onready var player_animation: AnimatedSprite2D = $PlayerAnimation
#var is_dead := false
#@onready var shape: CollisionShape2D = $Shape
#
#
#func _ready() -> void:
	#current_health = max_health
#
#
#func take_damage(amount: int):
	#current_health -= amount
	#print(current_health)
	#player_animation.play("Hit")
	#if current_health <= 0:
		#die()
		#
#func die():
	#print("Player Died!")
	#player_animation.play("Death")
	##await player_animation.animation_finished
	#collision_mask = 0
	##get_tree().reload_current_scene()
#
#func _physics_process(delta: float) -> void:
	##print(collision_mask)
	## Apply gravity
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	## Jump + Wall Jump
	##if is_on_wall():
			##shape.rotation_degrees = 90
	##else:
			##shape.rotation_degrees = 0
			#
	#if Input.is_action_just_pressed("JUMP") and (is_on_floor() or is_on_wall()):
		#velocity.y = JUMP_VELOCITY
	## Jump
	#if Input.is_action_just_pressed("JUMP"):
		## Normal jump
		#if is_on_floor():
			#velocity.y = JUMP_VELOCITY
#
			## Wall jump (requires ability)
		#elif AbilityManager.has("WallJump") and is_on_wall():
			#velocity.y = JUMP_VELOCITY
			## Push the player away from the wall
			#var push_dir = -sign(get_wall_normal().x)
			#velocity.x = Run_Speed * push_dir
#
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#var body = collision.get_collider()
#
		#if body is RigidBody2D:
			## Apply impulse in the direction you are pushing
			#body.apply_central_impulse(-collision.get_normal() * PUSH_FORCE)
	## Run / Walk Speed
	#var speed = Walk_Speed
	#if AbilityManager.has("Run"):
		#if Input.is_action_pressed("RUN") and not is_on_wall():
			#speed = Run_Speed
		#else:
			#speed = Walk_Speed
#
	## Movement Input
	#var direction := Input.get_axis("LEFT", "RIGHT")
	#if direction < 0:
		#player_animation.flip_h = true
	#elif direction > 0:
		#player_animation.flip_h = false
#
	## ✅ Animation Priority Fix
	#if is_on_wall() and not is_on_floor():
		#player_animation.play("Wall")
#
	#elif not is_on_floor():
		#player_animation.play("Jump")
#
	#elif direction == 0:
		#player_animation.play("Idle")
#
	#else:
		#player_animation.play("Run")
#
	## Horizontal Movement (no animation override here ✅)
	#if direction:
		#velocity.x = move_toward(velocity.x, speed * direction, speed * acc)
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed * dec)
#
	#move_and_slide()


























extends CharacterBody2D

const Walk_Speed = 150.0
const JUMP_VELOCITY = -330.0
@export var Run_Speed = 250
@export_range(0,1) var acc = 0.1
@export_range(0,1) var dec = 0.1
const PUSH_FORCE = 120.0

@export var max_health := 3
var current_health := max_health

@onready var player_animation: AnimatedSprite2D = $PlayerAnimation
var is_dead := false
@onready var shape: CollisionShape2D = $Shape


func _ready() -> void:
	current_health = max_health


func take_damage(amount: int):
	current_health -= amount
	print(current_health)
	player_animation.play("Hit")
	if current_health <= 0:
		die()


func die():
	print("Player Died!")
	player_animation.play("Death")
	collision_mask = 0
	#get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# -------------------------
	# NORMAL JUMP ONLY
	# -------------------------
	if Input.is_action_just_pressed("JUMP"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif AbilityManager.has("Wall_Jump") and is_on_wall():
			velocity.y = JUMP_VELOCITY

	# Push rigid bodies
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		if body is RigidBody2D:
			body.apply_central_impulse(-collision.get_normal() * PUSH_FORCE)

	# Run / Walk
	var speed = Walk_Speed
	if AbilityManager.has("Run"):
		if Input.is_action_pressed("RUN") and not is_on_wall():
			speed = Run_Speed
		else:
			speed = Walk_Speed

	# Movement Direction
	var direction := Input.get_axis("LEFT", "RIGHT")

	if direction < 0:
		player_animation.flip_h = true
	elif direction > 0:
		player_animation.flip_h = false
		
		#Anmations
	if is_on_wall() and not is_on_floor() and AbilityManager.has("Wall_Jump"):
		player_animation.play("Wall")

	elif not is_on_floor():
		player_animation.play("Jump")

	elif direction == 0:
		player_animation.play("Idle")

	else:
		player_animation.play("Run")


	# Horizontal Movement
	if direction:
		velocity.x = move_toward(velocity.x, speed * direction, speed * acc)
	else:
		velocity.x = move_toward(velocity.x, 0, speed * dec)

	move_and_slide()
