extends Control

signal finished

func _on_button_pressed() -> void:
	finished.emit()

func _on_focus_entered() -> void:
	$Center/Button.grab_focus()
