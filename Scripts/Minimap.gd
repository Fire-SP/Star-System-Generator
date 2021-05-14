extends Control

var minimap_node_list = []
var i = 0

func start():
	for i in len(global.node_list):
		var node = get_node("Node2D/Pivot").duplicate(true)
		var object = global.node_list[0]
		node.visible = true
		get_node("Node2D/Instanced").add_child(node)
		minimap_node_list.append(node)
		#node.get_child(0).set_position(Vector2(global.object_list_main[i][0]*2000,0))
		node.get_child(0).set_position(global.node_list[i].get_child(0).get_global_position()/5)
		node.set_rotation(object.get_rotation())
	
	get_node("Node2D/Sun").set_position(Vector2(-512,-300))


func _process(delta):
	if i == 1:
		start()
		
	if len(minimap_node_list) > 0:
		for i in len(global.node_list):
			var node = minimap_node_list[i]
			var object = global.node_list[i]
			node.set_rotation(object.get_rotation())
			
	get_node("Node2D/Player").set_position(((global.node_player.get_global_position()-Vector2(512,300))/5))
	if i > 10:
		i = 2
				
	i += 1
