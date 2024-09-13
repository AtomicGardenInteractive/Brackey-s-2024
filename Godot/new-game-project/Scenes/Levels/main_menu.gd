extends Control

signal start_game()
@export var buttons_v_box: VBoxContainer

func _ready() -> void: 
	focus_buttons()

func _on_start_game_pressed() -> void:
	start_game.emit()
	$"../../.."._on_start_game_called()
	hide()

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_visability_changed() -> void:
	if visible:
		focus_buttons()

func focus_buttons() -> void: 
	if buttons_v_box:
		var button: Button = buttons_v_box.get_child(0)
		if button is Button:
				button.grab_click_focus()
