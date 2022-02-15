extends Node


export var speed = 60  # How fast the player will move (pixels/sec).
export var wait_time = 1.0  # How fast the player will move (pixels/sec).
export var turn_wait_time = 0.5  # How fast the player will move (pixels/sec).
onready var cafe = get_parent()
var table
var time


# Called when the node enters the scene tree for the first time.
func _ready():
	table = search_for_table()
	time = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if(time > cafe.CLIENT_MIN_INTERVAL):
	 self.global_position = table.position
	
func search_for_table():
	for ctable in cafe.table_list:
		if not ctable.occupied:
			ctable.occupied = true
			return ctable
			

func move():
	pass
