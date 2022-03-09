extends Node2D

var reached
var can_move
export var speed = 1  # How fast the player will move (pixels/sec).

export var table_offset = Vector2(0,40)
onready var cafe = get_parent()
var table

# Called when the node enters the scene tree for the first time.
func _ready():
	reached = false
	can_move = false

func _process(delta):
	if(can_move):
		move()

func move():
	var vel = get_direction()
	vel = vel * speed
	
	self.position = self.position + vel
	
	self.position.x = (floor(self.position.x) if vel.x > 0 else ceil(self.position.x))
	self.position.y = (floor(self.position.y) if vel.y > 0 else ceil(self.position.y))
	
func get_direction():
	to_walk = self.position - (table.position + table_offset)

	if(to_walk.y != 0):
		self.set_animation("ClienteDesce")
		return Vector2(0, to_walk.y/to_walk.y)
	elif(to_walk.x != 0):
		if(turn == false):
			turn = true
			time = 0
			can_move = false
			wait_time = turn_wait_time
			return Vector2(0,0)
		if(to_walk.x > 0):
			self.set_animation("ClienteEsq")
			return Vector2(-to_walk.x/to_walk.x,0)
		self.set_animation("ClienteDir")
		return Vector2(to_walk.x/to_walk.x,0)

func table_reached():
	can_move = false
	
