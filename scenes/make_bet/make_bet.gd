class_name MakeBet
extends Control

signal finished(bet: float)

@onready var slider = $MarginContainer/PanelContainer/MarginContainer/Container/HSlider

func _on_button_pressed() -> void:
	var value = slider.value
	finished.emit(value)
