class_name ChatBox
extends Control

@onready var dialogue_label: DialogueLabel = %Text
@onready var container: HBoxContainer = %Container
@onready var sprites: CenterContainer = %Sprites
@onready var ringo: AnimatedSprite2D = %Ringo
@onready var margins: MarginContainer = $Margins

@onready var ringo_font: FontFile = preload("res://assets/fonts/wentira_font/Wentira.ttf")

signal finished_typing

func type_out(dialogue_line: DialogueLine):
	for child in sprites.get_children():
		child.hide()
	match dialogue_line.character:
		"Ringo":
			ringo.show()
			#dialogue_label.add_theme_font_override("normal_font", ringo_font)
	
	if dialogue_line.character:
		dialogue_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		container.layout_direction = LAYOUT_DIRECTION_RTL
	else:
		dialogue_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		container.layout_direction = LAYOUT_DIRECTION_LTR
	dialogue_label.dialogue_line = dialogue_line
	dialogue_label.type_out()
	await dialogue_label.finished_typing
	for child in sprites.get_children():
		(child as AnimatedSprite2D).stop()

func _ready() -> void:
	_update_size()

func _on_text_finished_typing() -> void:
	print("Finished typing")
	finished_typing.emit()

func _update_size() -> void:
	print(margins)
	if not margins: return
	custom_minimum_size.y = margins.size.y
	size.y = margins.size.y
	prints(custom_minimum_size, size, margins.size)
