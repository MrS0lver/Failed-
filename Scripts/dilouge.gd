#extends CanvasLayer
#
#@onready var panel = $Panel
#@onready var text_label = $Panel/RichTextLabel
#
#@export var text_speed: float = 0.03   # time (in sec) per character
#@export var auto_hide_delay: float = 1.0  # wait time before hiding (after text done)
#
#var is_showing := false
#var _full_text := ""
#var _displayed_text := ""
#var _char_index := 0
#var _timer := 0.0
#var _auto_hide_timer := 0.0
#var _text_finished := false
#
#func _ready():
	#panel.visible = false
	#text_label.text = ""
#

#func show_dialogue(text: String):
	#_full_text = text
	#_displayed_text = ""
	#_char_index = 0
	#_timer = 0.0
	#_auto_hide_timer = 0.0
	#_text_finished = false
	#text_label.text = ""
	#panel.visible = true
	#is_showing = true
#
#func _process(delta: float):
	#if is_showing and not _text_finished:
		#_timer += delta
		#if _timer >= text_speed and _char_index < _full_text.length():
			#_timer = 0.0
			#_displayed_text += _full_text[_char_index]
			#text_label.text = _displayed_text
			#_char_index += 1
#
		
		#if _char_index >= _full_text.length():
			#_text_finished = true
			#_auto_hide_timer = 0.0
#
	#elif is_showing and _text_finished:
		
		#_auto_hide_timer += delta
		#if _auto_hide_timer >= auto_hide_delay:
			#hide_dialogue()
#
#func hide_dialogue():
	#panel.visible = false
	#is_showing = false



#
#
#extends CanvasLayer
#
#@onready var panel = $Panel
#@onready var text_label = $Panel/RichTextLabel
#@onready var portrait: TextureRect = $Panel/TextureRect
#
#
#@export var text_speed: float = 0.03         
#@export var auto_hide_delay: float = 1.0      
#@export var default_portrait: Texture2D       
#
#var is_showing := false
#var _full_text := ""
#var _displayed_text := ""
#var _char_index := 0
#var _timer := 0.0
#var _auto_hide_timer := 0.0
#var _text_finished := false
#
#func _ready():
	#panel.visible = false
	#text_label.text = ""
	#if default_portrait:
		#portrait.texture = default_portrait
#
#
#func show_dialogue(text: String, img: Texture2D = null):
	#_full_text = text
	#_displayed_text = ""
	#_char_index = 0
	#_timer = 0.0
	#_auto_hide_timer = 0.0
	#_text_finished = false
	#text_label.text = ""
#
	#if img:
		#portrait.texture = img
	#elif default_portrait:
		#portrait.texture = default_portrait
	#else:
		#portrait.texture = null  
#
	#panel.visible = true
	#is_showing = true
#
#func _process(delta: float):
	#if is_showing and not _text_finished:
		#_timer += delta
		#if _timer >= text_speed and _char_index < _full_text.length():
			#_timer = 0.0
			#_displayed_text += _full_text[_char_index]
			#text_label.text = _displayed_text
			#_char_index += 1
#
		#if _char_index >= _full_text.length():
			#_text_finished = true
			#_auto_hide_timer = 0.0
#
	#elif is_showing and _text_finished:
		#_auto_hide_timer += delta
		#if _auto_hide_timer >= auto_hide_delay:
			#hide_dialogue()
#
#func hide_dialogue():
	#panel.visible = false
	#is_showing = false






extends CanvasLayer

@onready var panel = $Panel
@onready var text_label = $Panel/RichTextLabel
@onready var portrait: TextureRect = $Panel/TextureRect

@export var text_speed: float = 0.04        # delay per character
@export var auto_hide_delay: float = 1.5      # delay before auto hide
@export var default_portrait: Texture2D       # optional default image

var is_showing := false

func _ready():
	panel.visible = false
	text_label.text = ""
	if default_portrait:
		portrait.texture = default_portrait


# 💬 Awaitable dialogue function (you can call from any node)
func show_dialogue(text: String, img: Texture2D = null) -> void:
	if is_showing:
		# Wait until current dialogue finishes before showing new one
		await _wait_until_done()

	is_showing = true
	panel.visible = true
	text_label.text = ""
	var displayed_text := ""

	# Handle portrait
	if img:
		portrait.texture = img
	elif default_portrait:
		portrait.texture = default_portrait
	else:
		portrait.texture = null

	# ✨ Typewriter animation
	for i in text.length():
		displayed_text += text[i]
		text_label.text = displayed_text
		await get_tree().create_timer(text_speed).timeout

	# ⏳ Wait a bit, then hide
	await get_tree().create_timer(auto_hide_delay).timeout
	hide_dialogue()
	is_showing = false


func hide_dialogue():
	panel.visible = false


func _wait_until_done() -> void:
	while is_showing:
		await get_tree().process_frame
