extends Node2D

@onready var chat_scene = preload("res://scenes/chat/chat.tscn")
@onready var ringo_chat = preload("res://chats/intro_chat_with_ringo.dialogue")
@onready var flumbus = $Flumbus

func _physics_process(delta: float) -> void:
	var vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	flumbus.position += vector * 16

func _on_start_chatting_with_ringo(area: Area2D) -> void:
	print("asdf")
	%RingoUI.show()
	(%RingoUI.get_node("ChatWithRingo") as Button).grab_focus()

func _on_stop_chatting_with_ringo(body: Node2D) -> void:
	%RingoUI.hide()

func _on_chat_with_ringo_pressed() -> void:
	var chat = chat_scene.instantiate() as Chat
	chat.chat = ringo_chat
	get_tree().root.add_child(chat)
	
