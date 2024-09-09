extends Camera3D

@export var unitArray : Array = []

func _input(event):
	if event.is_action_pressed("Action_Select"):
		shoot_ray()

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
	
	if raycast_results:
		if raycast_results["collider"] is Boat:
			var targetBoat: Boat = raycast_results["collider"]
			add_to_array(targetBoat)
		else:
			pass
	else: 
		pass

func add_to_array(targetBoat:Boat):
	unitArray.sort()
	if unitArray.bsearch(targetBoat,true):
		unitArray.append(targetBoat)
	print(unitArray)
	pass
