extends CanvasLayer

const CHAR_READ_RATE = 0.05

#variaveis para a animação da caixa de texto
onready var textbox_container = $TextBoxContainer
onready var fundo = $FiltroFundoTextBox
onready var texto = $TextBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Texto
onready var proximo = $TextBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Proximo
onready var nome_personagem = $TextBoxContainer/MarginContainer/VBoxContainer/Personagem

enum State {
	READY,
	READING,
	FINISHED
}
var estado_atual = State.READY

#variaveis para o dialogo em si
onready var dialogo = get_parent().get_node("Dialogo").dialogo_dia_1
var index_dialogo = 0

#funcoes de animacao
func _process(delta):
	match estado_atual:
		State.READY:
			pass
		State.READING:
			if(Input.is_action_just_pressed("ui_accept")): #caso aperte enter quando estiver rolando a animação ela vai parar e mostrar o texto
				texto.percent_visible = 1.0
				$Tween.stop_all()
				_on_Tween_tween_all_completed()
		State.FINISHED:
			if(Input.is_action_just_pressed("ui_accept")):
				change_state(State.READY)
				load_dialogue()

func _ready():
	hide_textbox()
	load_dialogue()

func hide_textbox():
	textbox_container.hide()
	fundo.hide()
	texto.text=""
	nome_personagem.text = ""
	proximo.text = ""

func show_textbox():
	fundo.show()
	textbox_container.show()

func _on_Tween_tween_all_completed():
	proximo.text = ">>"
	change_state(State.FINISHED)

func change_state(prox_estado):
	estado_atual = prox_estado
	print ("Novo estado: " + str(prox_estado))


#funcao de troca de dialogo
func load_dialogue():

	print(index_dialogo)
	if index_dialogo < dialogo.size():
		show_textbox()
		change_state(State.READING)
		texto.text = dialogo[index_dialogo]["Texto"]
		nome_personagem.text = dialogo[index_dialogo]["Personagem"]
		#ele vai fazer uma transição do atributo porcentagem visivel por um periodo de tempo
		#igual ao tamanho da string de texto * a constante de tempo de leitura
		$Tween.interpolate_property(texto, "percent_visible", 0.0, 1.0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		index_dialogo += 1
	else:
		hide_textbox()
