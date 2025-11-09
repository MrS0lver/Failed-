extends Camera2D

@export var intensity: float = 2.0     # overall movement strength
@export var frequency: float = 1.5     # how "fast" the shake feels
@export var smoothness: float = 5.0    # higher = smoother transitions

var _target_offset: Vector2
var _original_offset: Vector2
var _timer: float = 0.0

func _ready():
	randomize()
	_original_offset = offset
	_pick_new_target()

func _process(delta: float):
	_timer -= delta
	if _timer <= 0.0:
		_pick_new_target()

	# Smoothly interpolate camera towards target offset
	offset = offset.lerp(_original_offset + _target_offset, delta * smoothness)

func _pick_new_target():
	_timer = randf_range(0.2, 0.6)  
	_target_offset = Vector2(
		randf_range(-1, 1),
		randf_range(-1, 1)
	) * intensity
