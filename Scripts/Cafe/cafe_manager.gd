extends Node

const day_lenght = 30.0

var transition

var time = 0.0
var aux_time = 0.0
var rng = RandomNumberGenerator.new()
var client_counter = 0
var client_limit = 3
var table_list = []
var card_list = []
var order_queue = []
var client_list = []
var money = 1000
var gato1
var gato2
onready var day_counter = 1

const CLIENT_MIN_INTERVAL = 0.5

signal body_entered
signal create_cards

onready var dialogues = $Textboxes
onready var dialogue_list = $Dialogo
onready var systemDia_list = $Sistema
var ocupados
var ocupadosLabel

enum TimeState {
	RUNNING,
	PAUSED
}

var funcionario
onready var estado_atual = TimeState.PAUSED
var dialogo_atual
onready var dialogo_ou_sistema = 1 #1 vai ser dialogo, 2 vai ser sistema

var transition_scene
var posso_prosseguir = 0
onready var primeiro_cliente = false
onready var primeiro_pedido = false
onready var primeiro_card = false

var pedidos

# Called when the node enters the scene tree for the first time.
func _ready():
	transition_scene = load("res://Scenes/Entity/TransitionDay.tscn")
	dialogues.hide_textbox()
	dialogues.hide_textbox_system()	
	
	gato1 = get_node("Cat1")
	gato2 = get_node("Cat2")
	ocupados = get_node("Ocupados/Panel")
	ocupadosLabel = get_node("Ocupados/Label")
	pedidos = get_node("Pedidos/Panel")
	gato1.hide()
	gato2.hide()
	ocupados.hide()
	ocupadosLabel.hide()
	pedidos.hide()
	funcionario = load("res://Scenes/Entity/Func.tscn").instance()
	funcionario.global_position = self.position + Vector2(750,380)
	add_child(funcionario)
	create_tables()
	create_cards()
	
	transition_screen_load()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if estado_atual == TimeState.RUNNING:
		#time += delta
		#if time > CLIENT_MIN_INTERVAL:
		#	aux_time += delta
		#	if aux_time > 1 and client_counter < client_limit:
		#		try_spawn()
		#		aux_time -= 1.0
			
		#if time >= day_lenght:
		#	time = 0.0
			#day_counter += 1
		#	transition_screen_load()
		#	estado_atual = TimeState.PAUSED
	pass

func create_tables():
	var table
	var table_path = "res://Scenes/Entity/Table.tscn"
	for i in range(3):
		table = load(table_path).instance()
		table_list.append(table)
		add_child(table)
		
	table_list[0].position = Vector2(488,288)
	table_list[0].dir_esq = 1
	table_list[1].position = Vector2(343,288)
	table_list[1].dir_esq = 2
	table_list[2].position = Vector2(153,288)
	table_list[2].dir_esq = 2

func create_cards():
	connect("create_cards", gato1, "_on_create_cards")
	connect("create_cards", gato2, "_on_create_cards")
	emit_signal("create_cards")

func try_spawn():
	var chance = time/2 * (client_limit - client_counter) * 1.5/client_limit
	var value = rng.randi_range(1,100)
	if value < chance:
		spawn_client()
		time = 0.0
		
	
func spawn_client():
	client_counter += 1
	var client_path = "res://Scenes/Entity/Client.tscn"
	var client = load(client_path).instance()
	client_list.append(client)
	client.global_position = self.position + Vector2(415,180)
	add_child(client)

func clear():
	for client in client_list:
		client.queue_free()

func transition_screen_load():
	transition = transition_scene.instance()
	add_child(transition)

func make_order():
	funcionario.get_order()
	
func cozinhando()

func day_manager():
	if day_counter == 1:
		if posso_prosseguir == 0:
			dialogo_atual = dialogue_list.dialogo_dia_1
			dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
			posso_prosseguir += 1
			
		elif posso_prosseguir == 1:
			estado_atual = TimeState.PAUSED
			gato1.hide()
			gato2.hide()
			dialogo_atual = systemDia_list.sistema_dia_1
			dialogo_ou_sistema = 2
			dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
			posso_prosseguir += 1
			
		elif posso_prosseguir == 2:
			funcionario.show()
			gato1.hide()
			gato2.hide()
			posso_prosseguir += 1
			spawn_client()
			
		elif posso_prosseguir == 3:
			estado_atual = TimeState.PAUSED
			gato1.hide()
			gato2.hide()
			yield(get_tree().create_timer(2.0), "timeout")
			dialogo_atual = systemDia_list.sistema_dia_1_cliente
			dialogo_ou_sistema = 2
			dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
			posso_prosseguir += 1
		
		elif posso_prosseguir == 4: #aqui ele vai esperar o cards ser arrastado, quando for arrastado e colidir tem que dar trigger na animacao do gato que eventualmente vai chamar o day_manager dnv
			ocupados.show()
			ocupadosLabel.show()
			posso_prosseguir += 1
			pass
			
		elif posso_prosseguir == 5:
			estado_atual = TimeState.PAUSED
			yield(get_tree().create_timer(1.0), "timeout")
			gato1.hide()
			gato2.hide()
			ocupados.hide()
			ocupadosLabel.hide()
			dialogo_atual = dialogue_list.dialogo_dia_1_capuccino
			dialogo_ou_sistema = 1
			dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
			posso_prosseguir += 1
			
		elif posso_prosseguir == 6:
			ocupados.show()
			ocupadosLabel.show()
			make_order()
			posso_prosseguir += 1
		
		elif posso_prosseguir == 7: #aqui a kenzie pegou o pedido e ele vai ter que ser atendido
			estado_atual = TimeState.PAUSED
			ocupados.hide()
			ocupadosLabel.hide()
			gato1.hide()
			gato2.hide()
			dialogo_atual = dialogue_list.dialogo_dia_1_cap_2
			dialogo_ou_sistema = 1
			dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
			posso_prosseguir += 1
		
		elif posso_prosseguir == 8:
			estado_atual = TimeState.PAUSED
			gato1.hide()
			gato2.hide()
			dialogo_atual = systemDia_list.sistema_dia_1_capuccino
			dialogo_ou_sistema = 2
			dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
			posso_prosseguir += 1
		
		elif posso_prosseguir == 9:
			ocupados.show()
			ocupadosLabel.show()
			pedidos.show()
			pedidos.get_node("ped1").show()
			posso_prosseguir += 1
		
		elif posso_prosseguir == 9:
			ocupados.show()
			ocupadosLabel.show()
			pedidos.show()
			pedidos.get_node("ped1").show()
			posso_prosseguir += 1
