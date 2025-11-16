extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_area_2d_body_entered(_body: CharacterBody2D) -> void:
	GameControl.set_player_enabled(false)
	await DilougeManager.show_dialogue("Enemies Ahead!",preload("res://Assets/Sprites/Dilouge.png"))
	await DilougeManager.show_dialogue("Dodge Them You Have 3 Healths",preload("res://Assets/Sprites/Dilouge.png"))
	GameControl.set_player_enabled(true)
	collision_shape_2d.disabled = true
