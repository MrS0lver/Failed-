extends ParallaxLayer

@export var OBJECT_Speed = -1

func _process(delta: float) -> void:
	self.motion_offset.x += OBJECT_Speed * delta
