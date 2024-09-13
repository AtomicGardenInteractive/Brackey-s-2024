extends Node
class_name GameHandler

@export var pause_menu: Control

var paused = true

func _ready() -> void:
	#connect("start_game()", _on_start_game_called())
	pass

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()

func pauseMenu():
	if paused: 
		pause_menu.hide() 
		get_tree().paused = true
	else: 
		pause_menu.show()
		get_tree().paused = false
	
	paused = !paused

func _on_start_game_called():
	pauseMenu()
	pass
