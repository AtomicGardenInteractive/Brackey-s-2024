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


func _on_contextual_command_called(target_position : Vector3, shiftHeld : bool) -> void:
	print(target_position)
	if shiftHeld:
		add_to_array(target_position)
	else:
		targetLocationArray.clear()
		add_to_array(target_position)
		next_navigation_target()


func add_to_array(target_location):
	if search_array(target_location) == true:
		print("location appended")
		targetLocationArray.append(target_location)
	else:
		print("location already present not appended")


func search_array(target_location):
	if targetLocationArray.count(target_location) < 1:
		return true
	else:
		return false

func next_navigation_target():
	print(targetLocationArray)
	current_target_location(targetLocationArray.pop_front())
	print(nav_agent.target_position)

func current_target_location(target_location):
	nav_agent.target_position = target_location


func _physics_process(_delta: float) -> void:
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	#print(str(next_location) + " - " + str(current_location) + " = " + str(next_location-current_location) + "/" + str(new_velocity))
	
	nav_agent.set_velocity(new_velocity)

func _on_navigation_agent_3d_target_reached() -> void:
	print("Reached Distination")
	
	next_navigation_target()



func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()
