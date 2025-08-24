class_name PlaySkuds
extends Control

signal finished(did_win)

@onready var game_ui = %GameUI
@onready var points_label = game_ui.get_node("Points")
@onready var post_game = %PostGame
@onready var post_game_label = %PostGame.get_node("Label")

@onready var dice_textures = [
	null,
	preload("res://assets/gfx/NapoleonsDice/diceOne.png"),
	preload("res://assets/gfx/NapoleonsDice/diceTwo.png"),
	preload("res://assets/gfx/NapoleonsDice/diceThree.png"),
	preload("res://assets/gfx/NapoleonsDice/diceFour.png"),
	preload("res://assets/gfx/NapoleonsDice/diceFive.png"),
	preload("res://assets/gfx/NapoleonsDice/diceSix.png")
]

var rng = RandomNumberGenerator.new()
var my_score = 0
var your_score = 0:
	set(new_score):
		your_score = new_score
		if points_label:
			points_label.text = str(your_score)
var rolls = []

func _ready() -> void:
	start()

func start() -> void:
	await get_tree().create_timer(1).timeout
	_show_buttons()

func _on_roll_pressed() -> void:
	%Buttons.hide()
	var tween = create_tween()
	tween.tween_property($DiePath/Follow, "progress_ratio", 1.0, 0.5)
	await tween.finished
	$DiePath/Follow.progress_ratio = 0
	
	var values = [1, 2, 3, 4, 5, 6]
	var weights = PackedFloat32Array([Globals.horrible_luck, 1, 1, 1, 1, 1])
	var roll = values[rng.rand_weighted(weights)]
	
	$DiceIndicator.texture = dice_textures[roll] 
	$DiceIndicator.restart()
	await $DiceIndicator.finished
	
	if roll == 1:
		# TODO Play failure animation
		print("Oh no, you failed")
		_finish_game(false)
	else:
		# TODO Cool roll finished animation?
		rolls.append(roll)
		your_score += roll
		_show_buttons()

func _show_buttons():
		%Buttons.show()
		%Roll.grab_focus()

func _on_margin_container_resized() -> void:
	custom_minimum_size.y = $MarginContainer.size.y
	
func _on_stick_pressed() -> void:
	var values = [1, 2, 3, 4, 5, 6]
	var weights = PackedFloat32Array([2, 1, 1, 0.5, 0.1, 0.1])
	for i in range(0, randi_range(2, 10)):
		var roll = values[rng.rand_weighted(weights)]
		if roll == 1:
			_finish_game(true)
			return
		else:
			my_score += roll
	_finish_game(your_score >= my_score)

func _finish_game(points: int):
	post_game_label.text = "Your score: {}\nMy score: {}".format([str(your_score), str(my_score)], "{}")
	post_game.show()
	game_ui.hide()
	await get_tree().create_timer(3).timeout
	finished.emit(points)
