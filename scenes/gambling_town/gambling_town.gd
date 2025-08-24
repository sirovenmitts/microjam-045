extends Node2D

@onready var chat_scene = preload("res://scenes/chat/chat.tscn")
@onready var flumbus = $Flumbus

func _physics_process(delta: float) -> void:
	var vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	flumbus.velocity = vector * 360
	flumbus.move_and_slide()

func _on_start_chat(chat: DialogueResource) -> void:
	var scene = chat_scene.instantiate() as Chat
	scene.chat = chat
	get_tree().root.add_child(scene)
	get_tree().root.remove_child(self)
