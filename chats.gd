extends Control

@export var chats: Control

@onready var chat_box = preload("res://ChatBox.tscn")
@onready var make_bet = preload("res://MakeBet.tscn")

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	var entry = chat_box.instantiate()
	entry.set_text("Hey, do you know where I can gamble?")
	entry.face_left()
	chats.add_child(entry)
	await get_tree().create_timer(1).timeout
	entry = chat_box.instantiate()
	entry.set_text("I'll betcha can't beat me. I am positively superfluous.")
	entry.face_right()
	chats.add_child(entry)
	await get_tree().create_timer(1).timeout
	entry = make_bet.instantiate()
	chats.add_child(entry)
