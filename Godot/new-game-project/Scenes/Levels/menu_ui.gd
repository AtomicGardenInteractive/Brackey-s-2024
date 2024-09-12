extends CanvasLayer

signal start_game()

@export var main_menu = %MainMenu

func _on_main_menu_start_game() -> void:
	start_game.emit()
	
	
