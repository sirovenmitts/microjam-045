class_name MakeChoice
extends Control

signal respond_with(response: DialogueResponse)

func make_choice(dialogue_line: DialogueLine):
	for response: DialogueResponse in dialogue_line.responses:
		var button = Button.new()
		button.text = response.text
		button.pressed.connect(func (): respond_with.emit(response), CONNECT_ONE_SHOT)
		%Container.add_child(button)
	return await respond_with


func _on_container_resized() -> void:
	custom_minimum_size.y = $MarginContainer.size.y
