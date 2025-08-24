class_name GuessTheNumber
extends Control

signal game_over(won: bool)
signal number_input

@onready var input_form = %InputForm
@onready var your_number_input = %YourNumberInput

var my_number_min: int
var my_number_max: int
var my_number: int
var your_number: int
var attempts: int

func start_game():
	my_number_min = randi_range(1, 10)
	my_number_max = randi_range(my_number_min + 1, 100)
	your_number_input.min_value = my_number_min
	your_number_input.max_value = my_number_max
	attempts = 0

func show_input_form():
	input_form.show()

func make_guess():
	attempts += 1
	
	if my_number == your_number:
		%Dialogue.text = "Fantastic! You are a winner, and so shall shrink"
		game_over.emit(true)
		return
	
	if attempts > 3:
		%Dialogue.text = "Too bad. So sad."
		await get_tree().create_timer(1).timeout
		game_over.emit(false)
		return

	match attempts:
		1:
			%Dialogue.text = "Pfaff and persimmons. Try again"
		2:
			%Dialogue.text = "Gah! Close! Or maybe far? Either way, it's not that"
		3:
			%Dialogue.text = "No."

	await get_tree().create_timer(1).timeout
	show_input_form()

func _ready() -> void:
	start_game()
	%Dialogue.text = "You, who has so little knowledge in the ways of numbers. I am thinking of a number between {} and {}. What could it possibly be? Eh? Care to test yourself?".format([my_number_min, my_number_max], "{}")
	show_input_form()

func _on_button_pressed() -> void:
	your_number = your_number_input.value
	input_form.hide()
	make_guess()


func _on_content_resized() -> void:
	custom_minimum_size.y = $MarginContainer.size.y
	size.y = $MarginContainer.size.y
