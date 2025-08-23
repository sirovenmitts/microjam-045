extends Control

func _ready():
	_refresh()

func _refresh():
	pass

func _on_size_changed() -> void:
	_refresh()
