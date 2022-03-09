extends Node2D

onready var animacao = get_node("KinematicBody2D/AnimatedSprite")
var initial_position

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
