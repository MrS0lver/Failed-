extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var animation: AnimatedSprite2D = $Animation



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	print("Collected!")
	animation.play("Collected")
	SpellSfx.play()
	await animation.animation_finished
	AbilityManager.unlock("Run")
	animation.visible = false
	cpu_particles_2d.emitting = false
	collision_shape_2d.disabled = true
