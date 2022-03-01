extends Node


export var speed = 1  # How fast the player will move (pixels/sec).
export var wait_time = 1.0  
export var turn_wait_time = 0.5
export var table_offset = Vector2(0,40)
onready var cafe = get_parent()
var table
var time
var to_walk
var can_move = false
var turn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print("cliente primeiro")
	table = search_for_table()
	
	time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if(time > wait_time):
		can_move = true
		wait_time = 0

	if(can_move):
		move()
	
func search_for_table():
	for ctable in cafe.table_list:
		if not ctable.occupied:
			ctable.occupied = true
			return ctable
			

func move():
	var vel = get_direction()
	vel = vel * speed
	
	self.position = self.position + vel
	
	self.position.x = (floor(self.position.x) if vel.x > 0 else ceil(self.position.x))
	self.position.y = (floor(self.position.y) if vel.y > 0 else ceil(self.position.y))
	
func get_direction():
	to_walk = self.position - (table.position + table_offset)
	if(to_walk.y != 0):
		return Vector2(0, to_walk.y/to_walk.y)
	elif(to_walk.x != 0):
		if(turn == false):
			turn = true
			time = 0
			can_move = false
			wait_time = turn_wait_time
			return Vector2(0,0)
		return Vector2(to_walk.x/to_walk.x,0)
	else:
		sit()
		return Vector2(0,0)

func sit():
	can_move = false
	cafe.order_queue.append(Order.new())
	pass
