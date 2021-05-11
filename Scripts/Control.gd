extends Control

func _ready():
	randomize()
	system_object_determine_atributes()
	system_visuals()	
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		reset()
		system_object_determine_atributes()
		system_visuals()
		
func reset():
	global.object_list_main.clear()
	for child in $"/root/Control/General/Instanced".get_children():
		child.queue_free()
	

func system_object_determine_atributes():
	###Setting Variables###
	global.star_size = rand_range(0.3,2.5)
	var star_size = global.star_size
	var old_number = rand_range(0.01,0.05)*global.star_size
	var object_outer_bound = global.star_size*40
	var object_frost_line = global.star_size*2.6
	var object_distance = 0
	var blue = (global.star_size+(pow(2.71828,(global.star_size*1.2)-0.5)/(1.15)-0.6))
	var green = (global.star_size+(pow(2.71828,global.star_size-1)/(0.85)-0.5))/2
	var object_size_modifier = 0
	var object_atmosphere_modifier = 0
	var object_water_modifier = 0
	
	#Main Creation Loop#
	while object_distance < object_outer_bound:
		object_distance = (old_number*rand_range(1.2,2.1)+0.01)
		old_number = object_distance+rand_range(0.1,0.2)
		var x = rand_range(0,4)
		var y = rand_range(0,10)
		var object_mass = ((pow(x,2))-(2*pow(x,3))/12)/1.5
		var object_type = global.object_types[int(rand_range(1,6))]
		var object_rotation_period = (((10/3)*pow(y,2))-((2*pow(y,3))/6))*5 # in Hours
		var object_axial_tilt = (((10/3)*pow(y,2))-((2*pow(y,3))/5))
	
		if object_mass <= 0.1:
			object_size_modifier = global.object_modifiers[1]
		elif object_mass > 0.1 and object_mass <= 0.5:
			object_size_modifier = global.object_modifiers[2]
		elif object_mass > 1 and object_mass <= 2:
			object_size_modifier = global.object_modifiers[3]
		elif object_mass > 2 and object_mass <= 3:
			object_size_modifier = global.object_modifiers[4]
		elif object_mass > 3:
			object_size_modifier = global.object_modifiers[5]
			
		var a = int(rand_range(1,5)+object_mass/2)
		if a <= 7:
			object_atmosphere_modifier = global.object_atmosphere_modifiers[a]
		else:
			object_atmosphere_modifier = global.object_atmosphere_modifiers[int(7/rand_range(1,1.5))]
			
		if object_type == "Rocky" or object_type == "Metallic":
			var b = int(object_mass - rand_range(-4,2))
			if b < 0:
				object_water_modifier = global.object_water_modifiers[0]
			elif b <= 6:
				object_water_modifier = global.object_water_modifiers[int((b))]
			else:
				object_water_modifier = global.object_water_modifiers[6]
				
			if object_atmosphere_modifier == "Nonexistent":
				object_water_modifier = global.object_water_modifiers[0]
			
			if object_distance < green:
				object_water_modifier = global.object_water_modifiers[0]
				
			if object_distance > blue:
				object_water_modifier = global.object_water_modifiers[0]
			
		else:
			object_water_modifier = "Nonexistent"
			
		### Making sure planet types make sense concerning their distance to their star ###
		if object_type == "Icy":
			if object_distance <= object_frost_line*2: # changes icy bodies inside the frost line to rocky ones.
				object_type = "Rocky"
			
		elif object_type == "Rocky" or object_type == "Metallic": # changes rocky bodies outside the frost lint to icy ones ( chance to )
			if object_distance >= object_frost_line*2 and rand_range(0,1) <= 0.75:
				object_type = "Icy"
				
		elif object_type == "Gas Giant":
			if object_distance >= object_frost_line*3 and rand_range(0,1) <= 0.5: # changes icy bodies inside the frost line to rocky ones.
				object_type = "Ice Giant"
				
		elif object_type == "Ice Giant":
			if object_distance <= object_frost_line*3:
				object_type = "Gas Giant"
		
			
		if object_type == "Gas Giant":
			object_mass = object_mass*200
		if object_type == "Ice Giant":
			object_mass = object_mass*50
			
		global.object_list_main.append([object_distance,object_mass,object_rotation_period,
		object_axial_tilt,object_size_modifier,object_type,object_atmosphere_modifier,
		object_water_modifier])
		
		
func system_visuals():
	
	var object_list_main = global.object_list_main
	var scale = 1
	
	for i in len(global.object_list_main):
		$"/root/Control/General/Star".self_modulate = Color(sin(global.star_size+0.8)*1.1,sin(global.star_size+0.5)*1.1,sin(global.star_size)*1.1)
		$"/root/Control/General/Star".scale = Vector2(global.star_size*2,global.star_size*2)
		var node = $"/root/Control/General/Node2D".duplicate(true)
		node.visible = true
		
		var color_options = [Color(0.6,0.4,0.2),Color(0.5,0.5,0.8),Color(0.6,0.6,0.6),Color(0.4,0.2,0.4),Color(0.5,0.5,0.8)]
		if object_list_main[i][5] == "Rocky":
			node.get_child(1).get_child(1).modulate = color_options[0]
		elif object_list_main[i][5] == "Icy":
			node.get_child(1).get_child(1).modulate = color_options[1]
		elif object_list_main[i][5] == "Metallic":
			node.get_child(1).get_child(1).modulate = color_options[2]
		elif object_list_main[i][5] == "Gas Giant":
			node.get_child(1).get_child(1).modulate = color_options[3]
		elif object_list_main[i][5] == "Ice Giant":
			node.get_child(1).get_child(1).modulate = color_options[4]
		
		if object_list_main[i][5] == "Rocky" or object_list_main[i][5] == "Icy" or object_list_main[i][5] == "Metallic":
			scale = 0.02*(object_list_main[i][1]*0.3)+0.005
		elif object_list_main[i][5] == "Gas Giant" or object_list_main[i][5] == "Ice Giant":
			scale = 0.02*(object_list_main[i][1]*0.006)+0.05

		
		node.get_child(1).get_child(1).scale = Vector2(scale,scale) # Scales the object sprite
		node.get_child(1).get_child(0).scale.y = scale*50 # Scales Axial tilt line
		node.set_position(Vector2((1150*global.star_size)+global.object_list_main[i][0]*(500),0))
		node.get_child(1).set_rotation(global.object_list_main[i][3]/90)

		if global.object_list_main[i][6] != "Nonexistent":
			node.get_child(2).get_child(0).visible = true
			
			if global.object_list_main[i][6] == "Extremely Thin" or global.object_list_main[i][6] == "Thin":
				node.get_child(2).get_child(0).self_modulate = Color(0.6,0.6,0.6,0.1)
				node.get_child(2).get_child(0).scale = Vector2(scale,scale)*1.2
				
			elif global.object_list_main[i][6] == "Substantial" or global.object_list_main[i][6] == "Thick":
				node.get_child(2).get_child(0).self_modulate = Color(0.6,0.6,0.6,0.3)
				node.get_child(2).get_child(0).scale = Vector2(scale,scale)*1.3
				
			elif global.object_list_main[i][6] == "Extremely Thick" or global.object_list_main[i][6] == "Crushing":
				node.get_child(2).get_child(0).self_modulate = Color(0.6,0.6,0.6,0.8)
				node.get_child(2).get_child(0).scale = Vector2(scale,scale)*1.4
				
		if global.object_list_main[i][5] == "Gas Giant" or global.object_list_main[i][5] == "Ice Giant":
			node.get_child(2).get_child(0).visible = false
			
		if global.object_list_main[i][5] == "Rocky" or global.object_list_main[i][5] == "Metallic" and global.object_list_main[i][6] != "Extremely Thin" or global.object_list_main[i][6] != "Nonexistent":
			node.get_child(2).get_child(1).scale = Vector2(scale,scale)*1.1
			
			if global.object_list_main[i][7] == "Lacustine" or global.object_list_main[i][6] == "Sub-Marine":
				node.get_child(2).get_child(1).modulate = Color(0,0,0.5,0.2)
				node.get_child(2).get_child(1).visible = true
				
			elif global.object_list_main[i][7] == "Marine":
				node.get_child(2).get_child(1).modulate = Color(0,0,1.5,0.4)
				node.get_child(2).get_child(1).visible = true
				
			elif global.object_list_main[i][7] == "Oceanic":
				node.get_child(2).get_child(1).modulate = Color(0,0,5.5,0.6)
				node.get_child(2).get_child(1).visible = true
				node.get_child(2).get_child(1).set_z_index(2)
				
			elif global.object_list_main[i][7] == "Hyper Oceanic":
				node.get_child(2).get_child(1).modulate = Color(0,0,10.5,0.8)
				node.get_child(2).get_child(1).visible = true
				node.get_child(2).get_child(1).set_z_index(2)
					
		else:
			node.get_child(2).get_child(1).visible = false
		var desc = node.get_child(0)
		desc.get_child(0).text += str(global.object_list_main[i][4])
		desc.get_child(0).text += " "
		desc.get_child(0).text += str(global.object_list_main[i][5])
		desc.get_child(0).text += " Body "
		
		desc.get_child(1).text += str(stepify(global.object_list_main[i][1],0.001))
		desc.get_child(1).text += " Earth Masses"
		
		desc.get_child(2).text += str(abs(stepify(global.object_list_main[i][2]/24,0.01)))
		desc.get_child(2).text += " (Days) Rotational Period"
		
		desc.get_child(3).text += str(stepify(global.object_list_main[i][3],0.01))
		desc.get_child(3).text +=  " Degree Axial Tilt"
		
		desc.get_child(4).text +=  str(stepify(global.object_list_main[i][0],0.001))
		desc.get_child(4).text += " AU"
		
		desc.get_child(5).text +=  str(global.object_list_main[i][6])
		desc.get_child(5).text +=  " Atmosphere"
		
		desc.get_child(6).text +=  str(global.object_list_main[i][7])

		$"/root/Control/General/Instanced".add_child(node)
		
