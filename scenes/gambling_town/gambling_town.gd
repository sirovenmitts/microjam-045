extends Node2D

@onready var chat_scene = preload("res://scenes/chat/chat.tscn")
@onready var flumbus = %Flumbus

var in_chat = false

func _physics_process(delta: float) -> void:
	if in_chat: return
	
	var vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	flumbus.velocity = vector * 500
	flumbus.move_and_slide()
	flumbus.get_node("Sprite").flip_h = vector.x > 0

func _on_start_chat(chat: DialogueResource) -> void:
	if in_chat: return
	in_chat = true
	%Chat.show()
	var bundle = await %Chat.start(chat)
	print(bundle)
	%Chat.hide()
	in_chat = false
