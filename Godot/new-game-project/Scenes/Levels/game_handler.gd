extends Node

@export var pause_menu: Control

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused: 
		pause_menu.hide() 
		get_tree().paused = true
	else: 
		pause_menu.show()
		get_tree().paused = false
	
	paused = !paused
