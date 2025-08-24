class_name Chat
extends Control

@export var chats: Control
@export var chat: DialogueResource
@export var chat_delay: float

@onready var chat_box = preload("res://scenes/chat_bubble/chat_bubble.tscn")
@onready var make_bet_scene = preload("res://scenes/make_bet/make_bet.tscn")
@onready var make_choice_scene = preload("res://scenes/make_choice/make_choice.tscn")
@onready var play_skuds_scene = preload("res://scenes/play_skuds/play_skuds.tscn")
@onready var exit_chat = preload("res://scenes/exit_chat/exit_chat.tscn")

var score = 0
var bet = 0

func add(child: Control):
	chats.add_child(child)
	chats.update_minimum_size()
	update_scroll.call_deferred()

func remove(child: Control):
	chats.remove_child(child)
	update_scroll.call_deferred()

func update_scroll() :
	var max_scroll = %ScrollContainer.get_v_scroll_bar().max_value
	%ScrollContainer.set_deferred("scroll_vertical", max_scroll)
	
func play_message(dialogue_line):
	match dialogue_line.type:
		"dialogue":
			var entry = chat_box.instantiate() as ChatBox
			add(entry)
			await entry.type_out(dialogue_line)
			return dialogue_line.next_id
		"response":
			var entry = make_choice_scene.instantiate() as MakeChoice
			add(entry)
			var response = await entry.make_choice(dialogue_line)
			remove(entry)
							
			var line = DialogueLine.new()
			line.text = response.text
			line.character = "Flumbus"
			
			entry = chat_box.instantiate() as ChatBox
			add(entry)
			await entry.type_out(line)
			return response.next_id

func play_conversation(dialogue: DialogueResource):
	var id = "start"
	while true:
		await get_tree().create_timer(1).timeout
		var dialogue_line = await dialogue.get_next_dialogue_line(id)
		if not dialogue_line: break
		id = await play_message(dialogue_line)
		if not id:
			break
	var scene = exit_chat.instantiate()
	add(scene)
	await scene.finished
	print("Exiting!")

func _ready() -> void:
	play_conversation(chat)

func make_bet() -> void:
	var scene = make_bet_scene.instantiate()
	add(scene)
	bet = await scene.finished

func play_skuds() -> void:
	var scene = play_skuds_scene.instantiate()
	add(scene)
	score = await scene.finished
	
