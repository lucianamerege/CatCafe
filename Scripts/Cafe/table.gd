extends Node2D

var occupied
var dir_esq
var aparencia
var client
var ordered

var sent_dir = preload("res://Assets/mesas-cadeiras-ocupadas-DIR.png")
var sent_esq = preload("res://Assets/mesas-cadeiras-ocupadas-ESQ.png")

# constructor
func _ready():
	aparencia = get_child(0)
	occupied = false;
	ordered = false;
	aparencia.hide()
	
func cliente_sentado(cliente):
	aparencia.show()
	client = cliente
	print(client)
	ordered = true;
	if dir_esq == 1:
		aparencia.set_texture(sent_dir)
	elif dir_esq == 2:
		aparencia.set_texture(sent_esq)

func _on_collide():
	print("colidiii")
	
