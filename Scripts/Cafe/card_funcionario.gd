extends Node
class_name Card

var carisma
var tecnica
var stamina
var nome

#construtor
func _init(car, tec, sta, name):
	nome = name
	carisma = car
	tecnica = tec
	stamina = sta

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
