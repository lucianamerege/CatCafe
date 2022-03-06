extends KinematicBody2D

var carisma
var tecnica
var stamina
var nome
var dragging = false
var start_position
onready var cafe = get_parent()

signal dragsignal;

func _ready():
	connect("dragsignal",self,"_set_drag_pc")
	nome = "Count Fang"
	carisma = 23
	tecnica = 10
	stamina = 200
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
	if(cafe.order_queue.length > 0 && stamina > 40):
		print('task executed')
		cafe.order_queue.remove(0)
		var task = cafe.order_queue[0]
	
func _on_Table1_body_entered(body):
	print('body entered', body.get_name())

func cookingTask(index):
	cafe.order_queue[index].task += 1 #passando a proxima etapa do pedido do cliente
	
func _on_Table1_body_exited(body):
	print('body exited')


func _on_Cozinhar_body_entered(body):
	pass # Replace with function body.


func _on_Cozinhar_body_exited(body):
	pass # Replace with function body.
