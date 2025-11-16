extends Node2D

@onready var witch_an: AnimatedSprite2D = $"Witch AN"
@onready var area_2d: Area2D = $Area2D
@onready var shape: CollisionShape2D = $Area2D/Shape

func _ready() -> void:
	witch_an.visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameControl.set_player_enabled(false)
		witch_an.visible = true
		witch_an.play("Spown")
		await DilougeManager.show_dialogue("Hey lonely Travellr !",preload("res://Assets/Sprites/Dilouge.png"))
		await DilougeManager.show_dialogue("I'm Khufra! I'm Here To Help U Out",preload("res://Assets/Sprites/Dilouge.png"))
		await DilougeManager.show_dialogue("Take Blue Spell To Run Faster : SHIFT",preload("res://Assets/Sprites/Dilouge.png"))
		witch_an.play("Die")
		await witch_an.animation_finished
		witch_an.visible = false
		area_2d.collision_mask = 0
		shape.disabled = true
		GameControl.set_player_enabled(true) 
	
	
	
