extends Node2D

@onready var sprite = $Sprite

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		sprite.play('talk')
		await get_tree().create_timer(5).timeout
		sprite.play("default")
	if Input.is_action_just_pressed("ui_right"):
		sprite.play("die")
	if Input.is_action_just_pressed("ui_up"):
		scale *= 1.1
	if Input.is_action_just_pressed("ui_down"):
		scale /= 1.1

func _on_animation_finished() -> void:
	sprite.play("default")
