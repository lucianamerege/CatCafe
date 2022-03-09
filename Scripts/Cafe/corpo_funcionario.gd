extends KinematicBody2D

func change_skin():
	get_parent().humano = true
	pass

func _ready():
	print(self)
