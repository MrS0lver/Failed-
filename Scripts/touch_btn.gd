extends CanvasLayer

func _ready():
	if ButtonManager.is_mobile:
		visible = true
		print("Touch buttons enabled for mobile.")
	else:
		visible = false
		print("Touch buttons hidden on PC.")
