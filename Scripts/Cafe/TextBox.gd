extends Node

const CHAR_READ_RATE = 0.05

#variaveis para a animação da caixa de texto
onready var textbox_container = $TextBox/TextBoxContainer
onready var texto = $TextBox/TextBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Texto
onready var nome_personagem = $TextBox/TextBoxContainer/MarginContainer/VBoxContainer/Personagem

onready var textbox_container_system = $SystemTextBox/MarginContainer
onready var texto_system = $SystemTextBox/MarginContainer/MarginContainer/Label

onready var fundo = $FiltroFundoTextBox

onready var cafe = get_parent()

enum State {
	READY,
	READING,
	FINISHED
}
onready var estado_atual = State.READY

var texto_atual
var dia_ou_sis

#variaveis para o dialogo em si
onready var dialogo = get_parent().get_node("Dialogo")
var index_dialogo = 0

signal fim_dialogo

func _ready():
	self.connect("fim_dialogo",cafe,"day_manager")
	
#funcoes de animacao
func _process(delta):
	match estado_atual:
		State.READY:
			pass
		State.READING:
			if(Input.is_action_just_pressed("ui_accept")): #caso aperte enter quando estiver rolando a animação ela vai parar e mostrar o texto
				if dia_ou_sis == 1:
					texto.percent_visible = 1.0
				else:
					texto_system.percent_visible = 1.0
				$Tween.stop_all()
				_on_Tween_tween_all_completed()
		State.FINISHED:
			if(Input.is_action_just_pressed("ui_accept")):
				change_state(State.READY)
				load_dialogue(texto_atual, dia_ou_sis)

func hide_textbox():
	textbox_container.hide()
	fundo.hide()
	texto.text=""
	nome_personagem.text = ""

func hide_textbox_system():
	textbox_container_system.hide()
	fundo.hide()
	texto_system.text=""

func show_textbox():
	fundo.show()
	textbox_container.show()
	
func show_textbox_system():
	fundo.show()
	textbox_container_system.show()

func _on_Tween_tween_all_completed():
	change_state(State.FINISHED)


func change_state(prox_estado):
	estado_atual = prox_estado

#funcao de troca de dialogo
func load_dialogue(var nome_dicionario, var dialogo_ou_sistema):
	texto_atual = nome_dicionario
	dia_ou_sis = dialogo_ou_sistema
	if index_dialogo < texto_atual.size():
		change_state(State.READING)
		
		if dialogo_ou_sistema == 1:
			show_textbox()
			texto.text = texto_atual[index_dialogo]["Texto"]
			nome_personagem.text = texto_atual[index_dialogo]["Personagem"]
			$Tween.interpolate_property(texto, "percent_visible", 0.0, 1.0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		else:
			show_textbox_system()
			texto_system.text = texto_atual[index_dialogo]["Texto"]
			$Tween.interpolate_property(texto_system, "percent_visible", 0.0, 1.0, 6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		#ele vai fazer uma transição do atributo porcentagem visivel por um periodo de tempo
		#igual ao tamanho da string de texto * a constante de tempo de leitura
		$Tween.start()

		index_dialogo += 1
	else:
		index_dialogo = 0
		if dialogo_ou_sistema == 1:
			hide_textbox()
		if dialogo_ou_sistema == 2:
			hide_textbox_system()
		cafe.estado_atual = cafe.TimeState.RUNNING
		cafe.gato1.show()
		cafe.gato2.show()
		emit_signal("fim_dialogo")
