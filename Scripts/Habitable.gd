extends Node2D

func _process(delta):
	
	get_child(1).set_position(Vector2(980*v.star_size+(1000*(pow(2.71828,v.star_size-1)/(0.85)-0.5)),10000))
	get_child(2).set_position(Vector2(980*v.star_size+(1000*(pow(2.71828,(v.star_size*1.2)-0.5)/(1.15)-0.6)),10000))
	get_child(3).set_position(Vector2(980*v.star_size+(1000*(pow(2.71828,v.star_size-1)/(0.85)-0.5)-10),10000))
	get_child(4).set_position(Vector2(980*v.star_size+(1000*(pow(2.71828,(v.star_size*1.2)-0.5)/(1.15)-0.6)-10),10000))

