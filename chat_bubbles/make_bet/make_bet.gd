class_name MakeBet
extends Control

signal finished(bet: float)

@onready var main_ui = %MainUi
@onready var confirm_ui = %ConfirmUi

func _ready() -> void:
	%Small.grab_focus()

func _on_small_pressed() -> void:
	main_ui.hide()
	confirm_ui.show()
	await get_tree().create_timer(1).timeout
	_update_size.call_deferred()
	finished.emit(0.1)

func _on_medium_pressed() -> void:
	main_ui.hide()
	confirm_ui.show()
	await get_tree().create_timer(1).timeout
	_update_size.call_deferred()
	finished.emit(0.3)

func _on_large_pressed() -> void:
	main_ui.hide()
	confirm_ui.show()
	await get_tree().create_timer(1).timeout
	_update_size.call_deferred()
	finished.emit(0.5)

func _update_size():
	custom_minimum_size.y = $Ui.size.y
	size.y = $Ui.size.y

func _on_ui_resized() -> void:
	_update_size()
