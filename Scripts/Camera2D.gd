extends RigidBody2D

func _process(delta):
	var direction = Vector2(0,0)
	var zoomed = 0
	var camera = get_node("Camera2D")
	
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0,5*camera.zoom.x)
	if Input.is_action_pressed("ui_up"):
		linear_velocity += Vector2(0,-1).rotated(get_rotation())
		direction += Vector2(0,-5*camera.zoom.x)
	if Input.is_action_pressed("ui_left"):
		angular_velocity -= 0.1
		direction += Vector2(-5*camera.zoom.x,0)
	if Input.is_action_pressed("ui_right"):
		angular_velocity += 0.1
		direction += Vector2(5*camera.zoom.x,0)
		
	if Input.is_action_pressed("ui_comma"):
		zoomed += 0.02
	if Input.is_action_pressed("ui_period"):
		zoomed -= 0.02
		
	if camera.zoom.x > 20:
		camera.zoom.x = 20
		camera.zoom.y = 20
	if camera.zoom.x < 0.1:
		camera.zoom.x = 0.1
		camera.zoom.y = 0.1
		
	camera.zoom.x += zoomed
	camera.zoom.y += zoomed

	zoomed = 0
	
