extends CharacterBody3D
class_name Boat

@export var boatID : int = 0
@export var boatStyle : Material
@export var SPEED = 3.0

@onready var nav_agent = $NavigationAgent3D

var targetLocationArray = []

func add_target_location(target_location):
	targetLocationArray.append(target_location)
	
func current_target_location(target_location):
	nav_agent.target_position = target_location
	pass


func add_to_array(target_location):
	if search_array(target_location) == true:
		print("location appended")
		targetLocationArray.append(target_location)
	else:
		print("location already presnent not appended")
	print(targetLocationArray)
	pass

func search_array(target_location):
	if targetLocationArray.count(target_location) < 1:
		return true
	else:
		return false

func _physics_process(delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalize * SPEED
	
	velocity = new_velocity
	move_and_slide()
	pass
