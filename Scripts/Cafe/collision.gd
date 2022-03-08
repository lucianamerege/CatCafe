extends Node

var table
var cafe

signal bla

# Called when the node enters the scene tree for the first time.
func _ready():
	print('ENTREI')
	table = get_parent()
	cafe = table.get_parent()
	print(table, cafe.gato1, cafe.gato2)
	
	self.connect("body_entered",cafe.gato1,"_on_table_body_entered")
	self.connect("body_entered",cafe.gato2,"_on_table_body_entered")
	self.connect("body_exited",cafe.gato1,"_on_table_body_exited")
	self.connect("body_exited",cafe.gato2,"_on_table_body_exited")
#	emit_signal("bla")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	emit_signal("bla")
