extends AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		play('talk')
		await get_tree().create_timer(5).timeout
		play("default")
	if Input.is_action_just_pressed("ui_right"):
		play("die")
	if Input.is_action_just_pressed("ui_up"):
		scale *= 2
	if Input.is_action_just_pressed("ui_down"):
		scale /= 2

func _on_animation_finished() -> void:
	play("default")
