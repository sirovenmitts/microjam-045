extends Node2D

@onready var chat_scene = preload("res://scenes/chat/chat.tscn")
@onready var flumbus = $Flumbus

func _physics_process(delta: float) -> void:
	var vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	flumbus.velocity = vector * 360
	flumbus.move_and_slide()

func _on_start_chat(chat: DialogueResource) -> void:
	pass
	# GameWorld.start_chat(chat)
