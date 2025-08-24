extends Node2D

func _on_interact_area_entered(area: Area2D) -> void:
	$UI.show()
	$UI/Container/Button.grab_focus()
	$Sprite.play("default")

func _on_interact_area_exited(area: Area2D) -> void:
	$UI.hide()
	$Sprite.play_backwards("default")
