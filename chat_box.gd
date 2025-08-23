extends Control

func set_text(text: String) -> void:
	%RichTextLabel.text = text

func face_left() -> void:
	%Container.layout_direction = LAYOUT_DIRECTION_LTR
	%RichTextLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT

func face_right() -> void:
	%Container.layout_direction = LAYOUT_DIRECTION_RTL
	%RichTextLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
