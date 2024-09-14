extends CharacterBody3D
class_name Boat

@export var boatID : int = 0
@export var boatStyle : Material
@export var SPEED = 3.0

@onready var nav_agent = $NavigationAgent3D
@onready var player : Player = %Player

var targetLocationArray = []

func _ready() -> void:
	player.connect("contextualCommand", _on_contextual_command_called)
	pass

func add_to_array(target_location):
	if search_array(target_location) == true:
		print("location appended")
		targetLocationArray.append(target_location)
	else:
		print("location already present not appended")
	print(targetLocationArray)
	pass
	
func search_array(target_location):
	if targetLocationArray.count(target_location) < 1:
		return true
	else:
		return false

func _physics_process(_delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	nav_agent.set_velocity(new_velocity)
	
	pass

func next_navigation_target():
	if !targetLocationArray.is_empty():
		current_target_location(targetLocationArray[0])
	pass

func _on_navigation_agent_3d_target_reached() -> void:
	targetLocationArray.erase(0)
	next_navigation_target()
	pass # Replace with function body.


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()

func _on_contextual_command_called(target_position : Vector3, shiftHeld : bool) -> void:
	print("_on_contextual_command_called")
	if shiftHeld:
		print("shiftHeld Passed")
		targetLocationArray.append(target_position)
		next_navigation_target()
	else:
		targetLocationArray.clear()
		targetLocationArray.append(target_position)
		next_navigation_target()
	pass

func current_target_location(target_location):
	nav_agent.target_position = target_location
	pass
