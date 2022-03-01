extends KinematicBody2D

var carisma
var tecnica
var stamina
var nome
var dragging = false
var start_position
onready var cafe = get_parent()
var overTable = 0

signal dragsignal;

func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	nome = "Catarina Preciosa"
	carisma = 64
	tecnica = 11
	stamina = 160
	start_position = position
	
func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)

func _set_drag_pc():
	dragging=!dragging

func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal") 
		elif event.button_index == BUTTON_LEFT and !event.pressed:
#			print("DROP", get_overlapping_areas())
			position = start_position
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = get_node("/root").event.get_position()
			
func executeTask():
	var tasks = cafe.order_queue
	if(cafe.order_queue.length > 0 && stamina > 40):
		print('task executed')
		cafe.order_queue.remove(0)
		stamina -= 40
	
func _on_Table1_body_entered(body):
	print('body entered')

func _on_Table1_body_exited(body):
	print('body exited')
