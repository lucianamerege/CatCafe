extends Node
class_name Table

var position
var occupied

# constructor
func _init(pos):
	occupied = false;
	position = pos;
	
func _on_Area2D_body_enter(body):
	print(str('Body entered: ', body.get_name()))

func _on_Area2D_body_exit(body):
	print(str('Body exited: ', body.get_name()))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
