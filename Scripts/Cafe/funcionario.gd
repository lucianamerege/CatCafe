extends Node2D

var can_move
export var speed = 1  # How fast the player will move (pixels/sec).

export var table_offset = Vector2(0,40)
onready var cafe = get_parent()
var table
var to_walk
var time
var turn = false
export var wait_time = 1.0 
export var turn_wait_time = 0.5
onready var animacao = get_node("KinematicBody2D/AnimatedSprite")
onready var humano = false
var gato1
signal order_taken
var initial_position

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	gato1 = get_parent().get_node("Cat1")
	connect("order_taken", gato1, "go_back_position")
	can_move = false
	time = 0.0
	initial_position = position

func _process(delta):
	if(can_move):
		move()
	if(turn == true):
		time += delta
		if(time > wait_time):
			can_move = true
			wait_time = 0

func search_for_table():
	for ctable in cafe.table_list:
		if ctable.ordered:
			ctable.ordered = true
			return ctable
			
func get_order():
	table = search_for_table()
	can_move = true

func move():
	var vel = get_direction()
	vel = vel * speed
	
	self.position = self.position + vel
	
	self.position.x = (floor(self.position.x) if vel.x > 0 else ceil(self.position.x))
	self.position.y = (floor(self.position.y) if vel.y > 0 else ceil(self.position.y))
	
func get_direction():
	to_walk = self.position - (table.position + table_offset)

	if (to_walk.x != 0):
		if(to_walk.x > 0):
			if humano == false:
				animacao.set_animation("Esq")
			elif humano == true:
				animacao.set_animation("Esq-Hum")
			return Vector2(-to_walk.x/to_walk.x,0)
	elif (to_walk.y != 0):
		if(turn == false):
			turn = true
			time = 0
			can_move = false
			wait_time = turn_wait_time
			return Vector2(0,0)
		animacao.set_animation("Cima-Hum")
		return Vector2(0, -to_walk.y/to_walk.y)
	
	if cafe.primeiro_pedido == false:
		cafe.primeiro_pedido = true
		cafe.day_manager()
	emit_signal("order_taken")
	animacao.set_animation("Parado")
	self.position = initial_position
	can_move = false
	self.set_process(false)
	return Vector2(0, 0)
	
func cozinhando():
	animacao.set_animation("Costas")
