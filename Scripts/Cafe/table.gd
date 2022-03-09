extends Node2D

var occupied
var dir_esq
var aparencia
var client
var ordered
var waiting

onready var moeda = get_node("Moeda")
var sent_dir = preload("res://Assets/mesas-cadeiras-ocupadas-DIR.png")
var sent_esq = preload("res://Assets/mesas-cadeiras-ocupadas-ESQ.png")
onready var cafe = get_parent()

# constructor
func _ready():
	waiting = false
	moeda.hide()
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

func finishing():
	moeda.show()
	yield(get_tree().create_timer(1.0), "timeout")
	moeda.hide()
	occupied = false;
	ordered = false;
	aparencia.hide()
	cafe.moedinhas.show()
	cafe.moedinhas.get_node("Label").text = "x" + str(cafe.money)
	if cafe.primeiro_termino == false:
		cafe.primeiro_termino = true
		cafe.day_manager()
