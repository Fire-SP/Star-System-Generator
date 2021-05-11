extends Camera2D

func _process(delta):
	var direction = Vector2(0,0)
	var zoomed = 0
	
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0,5*zoom.x)
	if Input.is_action_pressed("ui_up"):
		direction += Vector2(0,-5*zoom.x)
	if Input.is_action_pressed("ui_left"):
		direction += Vector2(-5*zoom.x,0)
	if Input.is_action_pressed("ui_right"):
		direction += Vector2(5*zoom.x,0)
		
	if Input.is_action_pressed("ui_comma"):
		zoomed += 0.02
	if Input.is_action_pressed("ui_period"):
		zoomed -= 0.02
		
	if zoom.x > 5:
		zoom.x = 5
		zoom.y = 5
	if zoom.x < 0.1:
		zoom.x = 0.1
		zoom.y = 0.1
		
	zoom.x += zoomed
	zoom.y += zoomed
	position += direction

	zoomed = 0
