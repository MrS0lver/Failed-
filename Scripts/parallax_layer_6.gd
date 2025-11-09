extends ParallaxLayer

@export var OBJECT_BIG_Speed = -10

func _process(delta: float) -> void:
	self.motion_offset.x += OBJECT_BIG_Speed * delta
