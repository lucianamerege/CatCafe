extends Node
class_name Card

var carisma
var tecnica
var stamina
var nome
var dragging = false

signal dragsignal;


#construtor
func _init(car, tec, sta, name):
	nome = name
	carisma = car
	tecnica = tec
	stamina = sta
	
func _ready():
	print("INICIO")
	connect("dragsignal",self,"_set_drag_pc")
	
func _process(delta):
	if dragging:
		var mousepos = get_viewport().get_mouse_position()
		self.position = Vector2(mousepos.x, mousepos.y)

func _set_drag_pc():
	dragging=!dragging

func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	print("tentativa de arrastar", event, shape_idx)
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("dragsignal")
		elif event.button_index == BUTTON_LEFT and !event.pressed:
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = event.get_position()

#func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
#	pass # Replace with function body.
