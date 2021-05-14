extends RigidBody2D

var recent_body = 0
var launch = false
var thrusting = false

var direction = Vector2(0,0)
var zoomed = 0

var recent_velocity = 0

func _ready():
	global.node_player = get_node(".") #required in the minimap script.
	

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
	
	var set_size = Vector2((camera.zoom.x)/3,(camera.zoom.x)/3)
	get_node("Camera2D/Control/ViewportContainer").set_position(Vector2((-1540*camera.zoom.x)/3,(-900*camera.zoom.y)/3))
	get_node("Camera2D/Control/ViewportContainer/Viewport/Control/Node2D/Player/Camera2D").zoom = camera.zoom*75
	get_node("Camera2D/Control/ViewportContainer").set_scale(Vector2(set_size))

func _process(delta):
	get_node("Camera2D").set_rotation(-get_rotation())
	var camera = get_node("Camera2D")
	if global.deltav > 0:
		if Input.is_action_pressed("ui_up"):
			thrusting = true
			linear_velocity += Vector2(0,-1).rotated(get_rotation())
			global.deltav -= 1
	if Input.is_action_pressed("ui_left"):
		angular_velocity -= 0.1
	if Input.is_action_pressed("ui_right"):
		angular_velocity += 0.1
		
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
				linear_velocity = Vector2(0,-20).rotated(get_rotation())
				
	get_node("Camera2D/Control/ViewportContainer/Speed").text = str(round(sqrt(pow(linear_velocity.x,2)+pow(linear_velocity.y,2))))
	get_node("Camera2D/Control/ViewportContainer/Speed").text += " m/s"
	
	get_node("Camera2D/Control/ViewportContainer/Deltav").text = str(global.deltav)
	get_node("Camera2D/Control/ViewportContainer/Deltav").text += "m/s of fuel"

func _on_RigidBody2D_body_entered(body):
	var contact_node = global.node_list.find(body.get_parent().get_parent())
	print(global.object_list_main[contact_node][5])
	if global.object_list_main[contact_node][5] != "Gas Giant" and global.object_list_main[contact_node][5] != "Ice Giant":
		launch = true
		recent_body = body
		return recent_body
		
	if global.object_list_main[contact_node][5] == "Gas Giant" or global.object_list_main[contact_node][5] == "Ice Giant":
		global.deltav = global.max_deltav


func _on_RigidBody2D_body_exited(body):
	launch = false
	recent_body = 0
	return recent_body
