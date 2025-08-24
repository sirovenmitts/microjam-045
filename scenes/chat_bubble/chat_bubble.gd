class_name ChatBox
extends Control

@onready var dialogue_label: DialogueLabel = %Text

signal finished_typing

func type_out(dialogue_line: DialogueLine):
	match dialogue_line.character:
		"Ringo":
			dialogue_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
			%Container.layout_direction = LAYOUT_DIRECTION_RTL
		"Flumbus":
			dialogue_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
			%Container.layout_direction = LAYOUT_DIRECTION_LTR
	dialogue_label.dialogue_line = dialogue_line
	custom_minimum_size.y = $MarginContainer.size.y
	prints("Chat box size", custom_minimum_size.y)

func _ready() -> void:
	custom_minimum_size.y = $MarginContainer.size.y

func _on_text_finished_typing() -> void:
	print("Finished typing")
	finished_typing.emit()

func _on_text_resized() -> void:
	custom_minimum_size.y = $MarginContainer.size.y
