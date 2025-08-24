class_name GameWorld
extends Node2D

@onready var chat_scene = preload("res://scenes/chat/chat.tscn")
@onready var current_scene = $CurrentScene
@onready var gambling_town = $CurrentScene/GamblingTown

func start_chat(chat: DialogueResource):
	var tween = create_tween()
	tween.tween_property($Curtain, "shader_parameter/height", 1, 0.5)
	await tween.finished
	current_scene.remove_child(gambling_town)
	var next_scene = chat_scene.instantiate()
	next_scene.chat = chat
	current_scene.add_child(next_scene)
	tween.tween_property($Curtain, "shader_parameter/height", 0, 0.5)
	await tween.finished

func end_chat():
	var tween = create_tween()
	tween.tween_property($Curtain, "shader_parameter/height", 1, 0.5)
	await tween.finished
	for scene in current_scene.get_children():
		current_scene.remove_child(scene)
		scene.queue_free()
	current_scene.add_child(gambling_town)
	tween.tween_property($Curtain, "shader_parameter/height", 0, 0.5)
	await tween.finished
