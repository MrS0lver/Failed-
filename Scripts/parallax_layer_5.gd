extends ParallaxLayer

@export var OBJECT_Seconc_Speed = -8

func _process(delta: float) -> void:
	self.motion_offset.x += OBJECT_Seconc_Speed * delta
