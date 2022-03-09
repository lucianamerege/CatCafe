extends KinematicBody2D

var carisma
var tecnica
var stamina
var nome
var dragging = false
var entered_kitchen = false
var start_position
onready var cafe = get_parent()

signal dragsignal
signal collide
signal collide_kitchen

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
			position = Vector2(880,500)
			emit_signal("dragsignal")
	elif event is InputEventScreenTouch:
		if event.pressed and event.get_index() == 0:
			self.position = get_node("/root").event.get_position()

func go_back_position():
	position = Vector2(236,525)

func _on_Cozinhar_body_entered(body):
	entered_kitchen = true
	cafe.cozinhando()
