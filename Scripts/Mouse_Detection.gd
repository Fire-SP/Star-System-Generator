extends Area2D


func _process(delta):
	set_position(Vector2(get_global_mouse_position()))
	
func _on_Mouse_Detection_area_entered(area):
	area.get_child(0).visible = true

func _on_Mouse_Detection_area_exited(area):
	area.get_child(0).visible = false
