class_name PlaySkuds
extends Control

signal finished(final_score: float)

@onready var game_ui = %GameUI
@onready var points_label = game_ui.get_node("Points")
@onready var post_game = $MarginContainer/PanelContainer/MarginContainer/PostGame
@onready var post_game_label = $MarginContainer/PanelContainer/MarginContainer/PostGame/Label

var rng = RandomNumberGenerator.new()
var points = 0:
	set(new_points):
		points = new_points
		if points_label:
			points_label.text = str(points)
var rolls = []

func _on_roll_pressed() -> void:
	var tween = create_tween()
	tween.tween_property($DiePath/Follow, "progress_ratio", 1.0, 0.5)
	await tween.finished
	$DiePath/Follow.progress_ratio = 0
	var values = [1, 2, 3, 4, 5, 6]
	var weights = PackedFloat32Array([Globals.horrible_luck, 1, 1, 1, 1, 1])
	var roll = values[rng.rand_weighted(weights)]
	
	if roll == 0:
		# TODO Play failure animation
		print("Oh no, you failed")
		_finish_game(0)
	else:
		# TODO Cool roll finished animation?
		rolls.append(roll)
		points += roll

func _on_margin_container_resized() -> void:
	custom_minimum_size.y = $MarginContainer.size.y
	
func _on_stick_pressed() -> void:
	# TODO Play game finished animation
	_finish_game(points)

func _finish_game(points: int):
	post_game_label.text = "Final score: {}".format([str(points)], "{}")
	post_game.show()
	game_ui.hide()
	remove_child($DiePath)
	_update_minimum_size.call_deferred()
	finished.emit(points)

func _update_minimum_size():
	custom_minimum_size.y = $MarginContainer.size.y
	size.y = $MarginContainer.size.y
