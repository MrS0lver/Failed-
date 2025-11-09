#extends CanvasLayer
#
#@onready var panel = $Panel
#@onready var text_label = $Panel/RichTextLabel
#
#@export var text_speed: float = 0.03  # time (in sec) per character
#
#var is_showing := false
#var _full_text := ""
#var _displayed_text := ""
#var _char_index := 0
#var _timer := 0.0
#
#func _ready():
	#panel.visible = false
	#text_label.text = ""
#
## 💬 Call this anywhere: DialogueManager.show_dialogue("Hey traveler!")
#func show_dialogue(text: String):
	#_full_text = text
	#_displayed_text = ""
	#_char_index = 0
	#_timer = 0.0
	#text_label.text = ""
	#panel.visible = true
	#is_showing = true
#
#func _process(delta: float):
	#if is_showing:
		## typewriter effect — show text slowly
		#_timer += delta
		#if _timer >= text_speed and _char_index < _full_text.length():
			#_timer = 0.0
			#_displayed_text += _full_text[_char_index]
			#text_label.text = _displayed_text
			#_char_index += 1
#
#func hide_dialogue():
	#panel.visible = false
	#is_showing = false
	
	
	#
	#
	#
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
## 💬 Call this anywhere: DialogueManager.show_dialogue("Hey traveler!")
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
		## typewriter effect — show text slowly
		#_timer += delta
		#if _timer >= text_speed and _char_index < _full_text.length():
			#_timer = 0.0
			#_displayed_text += _full_text[_char_index]
			#text_label.text = _displayed_text
			#_char_index += 1
#
		## when finished typing
		#if _char_index >= _full_text.length():
			#_text_finished = true
			#_auto_hide_timer = 0.0
#
	#elif is_showing and _text_finished:
		## wait a bit, then hide automatically
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


@export var text_speed: float = 0.03          # time per character
@export var auto_hide_delay: float = 1.0      # seconds before hide
@export var default_portrait: Texture2D       # fallback portrait image

var is_showing := false
var _full_text := ""
var _displayed_text := ""
var _char_index := 0
var _timer := 0.0
var _auto_hide_timer := 0.0
var _text_finished := false

func _ready():
	panel.visible = false
	text_label.text = ""
	if default_portrait:
		portrait.texture = default_portrait

# 💬 Call this like: DialogueManager.show_dialogue("Hey!", preload("res://faces/npc1.png"))
func show_dialogue(text: String, img: Texture2D = null):
	_full_text = text
	_displayed_text = ""
	_char_index = 0
	_timer = 0.0
	_auto_hide_timer = 0.0
	_text_finished = false
	text_label.text = ""

	if img:
		portrait.texture = img
	elif default_portrait:
		portrait.texture = default_portrait
	else:
		portrait.texture = null  # hide if none

	panel.visible = true
	is_showing = true

func _process(delta: float):
	if is_showing and not _text_finished:
		_timer += delta
		if _timer >= text_speed and _char_index < _full_text.length():
			_timer = 0.0
			_displayed_text += _full_text[_char_index]
			text_label.text = _displayed_text
			_char_index += 1

		if _char_index >= _full_text.length():
			_text_finished = true
			_auto_hide_timer = 0.0

	elif is_showing and _text_finished:
		_auto_hide_timer += delta
		if _auto_hide_timer >= auto_hide_delay:
			hide_dialogue()

func hide_dialogue():
	panel.visible = false
	is_showing = false
