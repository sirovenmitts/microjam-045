class_name Chat
extends Control

@export var chat_heading: PackedScene
@export var chat_box: PackedScene
@export var make_bet_scene: PackedScene
@export var make_choice_scene: PackedScene

@onready var chats = %Chats

var did_bet = false
var did_win = false
var bet = 0

var dice_my_score = 0
var dice_my_last_roll = 0
var dice_my_rolls = []

var dice_your_score = 0
var dice_your_last_roll = 0
var dice_your_rolls = []

var rng = RandomNumberGenerator.new()

func add(child: Control):
	chats.add_child(child)
	chats.update_minimum_size()
	_update_scroll_container_size.call_deferred()

func remove(child: Control):
	chats.remove_child(child)
	_update_scroll_container_size.call_deferred()

func _update_scroll_container_size() :
	var max_scroll = %ScrollContainer.get_v_scroll_bar().max_value
	%ScrollContainer.set_deferred("scroll_vertical", max_scroll)

func _add_chat_bubble(chat: DialogueLine):
	var bubble = chat_box.instantiate() as ChatBox
	add(bubble)
	await bubble.type_out(chat)

func play_message(dialogue_line):
	match dialogue_line.type:
		"dialogue":
			await _add_chat_bubble(dialogue_line)
			return dialogue_line.next_id
		"response":
			var entry = make_choice_scene.instantiate() as MakeChoice
			add(entry)
			var response = await entry.make_choice(dialogue_line)
			remove(entry)
							
			var line = DialogueLine.new()
			line.text = response.text
			await _add_chat_bubble(line)
			return response.next_id

func start(chat: DialogueResource):
	var id = "start"
	while true:
		var dialogue_line = await chat.get_next_dialogue_line(id, [self])
		if not dialogue_line: break
		id = await play_message(dialogue_line)
		if not id:
			break
	await get_tree().create_timer(1).timeout
	return [did_bet, did_win]
	

func make_bet() -> void:
	var scene = make_bet_scene.instantiate()
	add(scene)
	bet = await scene.finished
	did_bet = true

func dice_start():
	dice_my_score = 0
	dice_my_last_roll = 0
	dice_your_score = 0
	dice_your_last_roll = 0

func dice_end():
	var values = [1, 2, 3, 4, 5, 6]
	var weights = PackedFloat32Array([1.1, 2, 2, 0.5, 0.1, 0.1])
	for i in range(0, randi_range(1, dice_your_rolls.size())):
		dice_my_last_roll = values[rng.rand_weighted(weights)]
		dice_my_rolls.append(dice_my_last_roll)
		if dice_my_last_roll == 1:
			dice_my_score = 0
			did_win = true
			break
		else:
			dice_my_score += dice_my_last_roll
	did_win = dice_your_score >= dice_my_score

func dice_roll():
	var values = [1, 2, 3, 4, 5, 6]
	var weights = PackedFloat32Array([Globals.horrible_luck, 1, 1, 1, 1, 1])
	dice_your_last_roll = values[rng.rand_weighted(weights)]
	dice_your_rolls.append(dice_your_last_roll)
	if dice_your_last_roll == 1:
		dice_your_score = 0
		did_win = false
	else:
		dice_your_score += dice_your_last_roll

func play_guess_the_numbers() -> void:
	#var scene = guess_the_number.instantiate() as GuessTheNumber
	#add(scene)
	#var did_win = await scene.game_over
	pass

func _on_chats_resized() -> void:
	_update_scroll_container_size.call_deferred()
