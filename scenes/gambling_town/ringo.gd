extends Node2D

signal start_chat(chat: DialogueResource)

@export var chat: DialogueResource

func _on_interact_area_entered(area: Area2D) -> void:
	$UI.show()
	$UI/Chat.grab_focus()
	$Sprite.play("default")

func _on_interact_area_exited(area: Area2D) -> void:
	$UI.hide()
	$Sprite.play_backwards("default")

func _on_chat_pressed() -> void:
	#start_chat.emit(chat)
	# GameWorld.start_chat(chat)
	pass
