extends Node

var is_mobile: bool = false
var is_pc: bool = false

func _ready():
	var platform := OS.get_name()
	if platform in ["Android", "iOS"]:
		is_mobile = true
		is_pc = false
	else:
		is_mobile = false
		is_pc = true
	print("Running on:", platform, "| Mobile:", is_mobile, "| PC:", is_pc)
