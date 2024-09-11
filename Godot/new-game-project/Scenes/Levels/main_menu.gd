extends Control

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/game_handler.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://options_menu.tscn")


func _on_quit_game_pressed():
	get_tree().quit()
	
	
