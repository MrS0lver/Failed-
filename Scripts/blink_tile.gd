#extends StaticBody2D
#
#@onready var tile_shape: CollisionShape2D = $TileShape
#@onready var timer: Timer = $Timer
#@onready var sprite_2d: Sprite2D = $Sprite2D
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("Body Entered Mate!")
	#timer.start()
#
#
#
#func _on_timer_timeout() -> void:
	#tile_shape.disabled = true
	#sprite_2d.visible = false
	#print("Disabled!")

extends StaticBody2D

@onready var tile_shape: CollisionShape2D = $TileShape
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var tile_an: AnimatedSprite2D = $TileAN



var is_active = true 

func _ready() -> void:
	tile_shape.disabled = false
	#sprite_2d.visible = true
	tile_an.visible = true
	#timer.timeout.connect(_on_timer_timeout)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and is_active:
		tile_an.play("Blink")
		print("Player stepped on tile!")
		is_active = false
		timer.start()  

func _on_timer_timeout() -> void:
	tile_shape.disabled = true
	#sprite_2d.visible = false
	tile_an.hide()
	print("Tile disappeared!")
	
	
	
	#ReSpawn
	await get_tree().create_timer(0.5).timeout 
	tile_shape.disabled = false
	#sprite_2d.visible = true
	tile_an.visible = true
	is_active = true
	print("Tile respawned!")
