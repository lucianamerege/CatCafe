extends Node2D

onready var cafe = get_parent()
onready var label = get_node("QueDiaEh")
onready var botao = get_node("IniciarDia")
signal fim_transicao

func _ready(): #enter_tree é chamado sempre que entra na arvore
	self.connect("fim_transicao",cafe,"day_manager")
	
	label.text = ""
	print(label)
	print(label.text)
	botao.hide()
	print(str(cafe.day_counter))
	label.text = "Dia " + str(cafe.day_counter)
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	pass

func _on_Tween_tween_all_completed():
	botao.show()

func _on_IniciarDia_button_down():
	emit_signal("fim_transicao")
	queue_free()
