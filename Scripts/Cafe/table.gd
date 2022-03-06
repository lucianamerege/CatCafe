extends Node2D

var occupied
var dir_esq
var aparencia

var sent_dir = preload("res://Assets/mesas-cadeiras-ocupadas-DIR.png")
var sent_esq = preload("res://Assets/mesas-cadeiras-ocupadas-ESQ.png")

# constructor
func _ready():
	aparencia = get_child(0)
	occupied = false;
	aparencia.hide()
	
func _on_Area2D_body_enter(body):
	print(str('Body entered AWUI: ', body.get_name()))

func _on_Area2D_body_exit(body):
	pass

func cliente_sentado():
	aparencia.show()
	if dir_esq == 1:
		aparencia.set_texture(sent_dir)
	elif dir_esq == 2:
		aparencia.set_texture(sent_esq)
