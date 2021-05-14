extends Node2D

var tick = -2
func _ready():
	print("trails should be good")
	
func _physics_process(delta):
	tick += 1
	if tick == -1:
		for i in len(global.object_list_main):
			var node = get_node("trail").duplicate(true)
			add_child(node)
		
	if tick > 10:
		tick = 0
		
	player_trail()
	object_trail()
	
func player_trail():
	if tick == 5:
		get_node("trail").add_point(get_parent().get_node("RigidBody2D/Rocket").get_global_position())

	if get_node("trail").get_point_count() > 150:
		get_node("trail").remove_point(0)
		
		
func object_trail():
	if tick == 10:
		for i in len(global.object_list_main):
			var node = global.node_list[i]
			if len(global.node_list) != 0:
				get_child(i+1).add_point(node.get_child(0).get_global_position())
			
			if get_child(i+1).get_point_count() > 400:
				get_child(i+1).remove_point(0)
