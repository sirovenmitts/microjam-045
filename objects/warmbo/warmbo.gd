extends Node2D

signal start_chat(chat: DialogueResource)

@export var chat: DialogueResource

func _on_interact_area_entered(area: Area2D) -> void:
	$Sprite.play("default")
	$UI.show()
	$UI/Center/Chat.grab_focus()
	
func _on_interact_area_exited(area: Area2D) -> void:
	$Sprite.play_backwards("default")
	$UI.hide()

func _on_chat_pressed() -> void:
	start_chat.emit(chat)
