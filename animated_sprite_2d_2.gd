extends AnimatedSprite2D

func _ready():
	await get_tree().create_timer(3).timeout
	play("reveal")
	await animation_finished
	play("default")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		play("talk")
		await get_tree().create_timer(5).timeout
		play("default")
