extends Node2D

@export var chat_with_warmbo: DialogueResource

@onready var chat_scene = preload("res://scenes/chat/chat.tscn")
@onready var ringo_chat = preload("res://chats/intro_chat_with_ringo.dialogue")
@onready var flumbus = $Flumbus

func _physics_process(delta: float) -> void:
	var vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	flumbus.velocity = vector * 360
	flumbus.move_and_slide()

func _on_start_chatting_with_ringo(area: Area2D) -> void:
	print("asdf")
	%RingoUI.show()
	(%RingoUI.get_node("ChatButton") as Button).grab_focus()

func _on_stop_chatting_with_ringo(body: Node2D) -> void:
	%RingoUI.hide()

func _on_chat_with_ringo_pressed() -> void:
	var chat = chat_scene.instantiate() as Chat
	chat.chat = ringo_chat
	get_tree().root.add_child(chat)
	get_tree().root.remove_child(self)

func _on_start_chatting_with_warmbo(area: Area2D) -> void:
	%Warmbo.play("reveal")
	%WarmboUi.show()
	(%WarmboUi.get_node("Center/ChatButton") as Button).grab_focus()

func _on_stop_chatting_with_warmbo(area: Area2D) -> void:
	%WarmboUi.hide()
	%Warmbo.play_backwards("reveal")

func _on_chat_with_warmbo_pressed() -> void:
	var chat = chat_scene.instantiate() as Chat
	chat.chat = chat_with_warmbo
	get_tree().root.add_child(chat)
	get_tree().root.remove_child(self)
