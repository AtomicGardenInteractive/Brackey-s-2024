extends Camera3D

@export var unitArray : Array = []

func _input(event):
#Gets object object under cursor then checks if boat is already in selected units, if it not clear array then adds it to selected units
	if event.is_action_pressed("Action_Select"):
		var hitObject = shoot_ray()
		if hitObject:
			if hitObject["collider"] is Boat:
				var targetBoat: Boat = hitObject["collider"]
				clear_array()
				add_to_array(targetBoat)
			else:
				pass
		else: 
			pass
#Gets object object under cursor then checks if boat is already in selected units, if it not adds it to selected units
	if event.is_action_pressed("Action_Queue_Select"):
		var hitObject = shoot_ray()
		if hitObject:
			if hitObject["collider"] is Boat:
				var targetBoat: Boat = hitObject["collider"]
				add_to_array(targetBoat)
			else:
				pass
		else: 
			pass

	if event.is_action_pressed("Action_Command"):
		#
		pass

#Gets objects under cursor
func shoot_ray():
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_lenght = 1000
	var from = project_ray_origin(mouse_pos)
	var to = from + project_ray_normal(mouse_pos) * ray_lenght
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_results = space.intersect_ray(ray_query)
	print(raycast_results)
	return raycast_results


func clear_array():
	unitArray.clear()
	pass

func add_to_array(targetBoat:Boat):
	if search_array(targetBoat) == true:
		print("boat appended")
		unitArray.append(targetBoat)
	else:
		print("boat already presnent not appended")
	print(unitArray)
	pass

func search_array(targetBoat:Boat):
	if unitArray.count(targetBoat) < 1:
		return true
	else:
		return false
