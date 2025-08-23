extends HSlider

@export var shrink_me: Node2D
@export var grow_me: Node2D
@export var hyperbole: float

func _on_value_changed(value: float) -> void:
	var risk = remap(value, min_value, max_value, 0, 0.1)
	shrink_me.scale = Vector2.ONE - Vector2.ONE * risk * hyperbole
	grow_me.scale = Vector2.ONE + Vector2.ONE * risk * hyperbole
