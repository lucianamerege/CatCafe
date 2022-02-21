extends Node2D

var day_counter=1
onready var label = get_node("QueDiaEh")
onready var botao = get_node("IniciarDia")

func _ready(): #enter_tree é chamado sempre que entra na arvore
	label.text = ""
	print(label)
	print(label.text)
	botao.hide()
	label.text = "Dia " + str(day_counter)
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	day_counter=day_counter+1
	pass

func _on_Tween_tween_all_completed():
	botao.show()

func _on_IniciarDia_button_down():
	get_tree().change_scene("res://Scenes/Level/Cafe.tscn")
