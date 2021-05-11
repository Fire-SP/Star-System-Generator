extends Node2D

func _process(delta):
	
	get_child(0).scale = (Vector2((3.2*(pow(2.71828,global.star_size-0.75)/(0.85)-0.5)),3.2*(pow(2.71828,global.star_size-0.75)/(0.85)-0.5)))
	get_child(1).scale = (Vector2((3.7*(pow(2.71828,(global.star_size*1.2)-0.5)/(1.15)-0.6)),3.7*(pow(2.71828,(global.star_size*1.2)-0.5)/(1.15)-0.6)))
	get_child(2).scale = (Vector2((3.2*(pow(2.71828,global.star_size-0.768)/(0.85)-0.5)),3.2*(pow(2.71828,global.star_size-0.768)/(0.85)-0.5)))
	get_child(3).scale = (Vector2((3.7*(pow(2.71828,(global.star_size*1.19)-0.5)/(1.15)-0.6)),3.7*(pow(2.71828,(global.star_size*1.19)-0.5)/(1.15)-0.6)))
	
#	get_child(4).set_position(Vector2(980*global.star_size+(1000*(pow(2.71828,global.star_size-1)/(0.85)-0.5)),10000))
#	get_child(5).set_position(Vector2(980*global.star_size+(1000*(pow(2.71828,(global.star_size*1.2)-0.5)/(1.15)-0.6)),10000))
#	get_child(6).set_position(Vector2(980*global.star_size+(1000*(pow(2.71828,global.star_size-1)/(0.85)-0.5)-10),10000))
#	get_child(7).set_position(Vector2(980*global.star_size+(1000*(pow(2.71828,(global.star_size*1.2)-0.5)/(1.15)-0.6)-10),10000))

