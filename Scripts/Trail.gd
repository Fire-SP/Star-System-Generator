extends Node2D

var tick = 1



func _process(delta):
	tick += 1
	self.modulate = Color(1,1,1,1/(tick*0.001))
	if tick > 5000:
		queue_free()
