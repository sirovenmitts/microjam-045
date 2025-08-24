extends Control

signal finished

func _on_button_pressed() -> void:
	finished.emit()
	#GameWorld.exit_chat()
