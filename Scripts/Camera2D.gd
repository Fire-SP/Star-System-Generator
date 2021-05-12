extends RigidBody2D

var recent_body = 0
var launch = false
var thrusting = false
onready var node = preload("res://Scenes/Trail.tscn")

var direction = Vector2(0,0)
var zoomed = 0

var recent_velocity = 0
var tick = 0

func _input(event):
	var camera = get_node("Camera2D")
	if Input.is_action_pressed("ui_comma") or Input.is_action_pressed("mouse_scroll_down"):
		zoomed += 0.15
	if Input.is_action_pressed("ui_period") or Input.is_action_pressed("mouse_scroll_up"):
		zoomed -= 0.15
		
		
	if camera.zoom.x > 20:
		camera.zoom.x = 20
		camera.zoom.y = 20
	if camera.zoom.x < 0.1:
		camera.zoom.x = 0.1
		camera.zoom.y = 0.1
		
	camera.zoom.x += zoomed
	camera.zoom.y += zoomed

func _process(delta):
	tick += 1
	var camera = get_node("Camera2D")
	if Input.is_action_pressed("ui_down"):
		direction += Vector2(0,5*camera.zoom.x)
	if Input.is_action_pressed("ui_up"):
		thrusting = true
		linear_velocity += Vector2(0,-2.5).rotated(get_rotation())
		direction += Vector2(0,-5*camera.zoom.x)
	if Input.is_action_pressed("ui_left"):
		angular_velocity -= 0.1
		direction += Vector2(-5*camera.zoom.x,0)
	if Input.is_action_pressed("ui_right"):
		angular_velocity += 0.1
		direction += Vector2(5*camera.zoom.x,0)
		
	if Input.is_action_pressed("ui_up") != true:
		thrusting = false
		
	if thrusting != true:
		get_node("Rocket/Line2D2").visible = false
	elif thrusting == true:
		get_node("Rocket/Line2D2").visible = true

	zoomed = 0
	
	if recent_body:
		if launch == true:
			var x = recent_body.get_global_position()
			set_position(Vector2(x.x,x.y-(10*recent_body.scale.x)))
			set_rotation_degrees(0)
		
			if Input.is_action_pressed("ui_up"):
				launch = false
				linear_velocity += Vector2(0,-2).rotated(get_rotation())
				
	if launch == false:
			recent_velocity = linear_velocity
	
	if tick > 50:
		tick = 0
		var new_node = node.instance()
		new_node.set_position(get_node("Rocket").get_global_position())
		get_parent().get_node("Trails").add_child(new_node)
		
func _on_RigidBody2D_body_entered(body):
	launch = true
	recent_body = body
	return recent_body


func _on_RigidBody2D_body_exited(body):
	launch = false
	recent_body = 0
	return recent_body
