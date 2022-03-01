extends Node
const day_lenght = 60.0

var transition

var time = 0.0
var aux_time = 0.0
var rng = RandomNumberGenerator.new()
var client_counter = 0
var client_limit = 3
var table_list = []
var card_list = []
var order_queue = []
var money = 1000
onready var day_counter = 1

const CLIENT_MIN_INTERVAL = 3.0

onready var dialogues = $Textboxes
onready var dialogue_list = $Dialogo
onready var systemDia_list = $Sistema

enum TimeState {
	RUNNING,
	PAUSED
}
onready var estado_atual = TimeState.PAUSED
var dialogo_atual
onready var dialogo_ou_sistema = 1 #1 vai ser dialogo, 2 vai ser sistema

var transition_scene
var posso_prosseguir = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	transition_scene = load("res://Scenes/Entity/TransitionDay.tscn")
	dialogues.hide_textbox()
	dialogues.hide_textbox_system()
#	$CanvasLayer/Menu_Cards.hide()
#	$Area2D_Kitchen/CollisionShape2D_Kitchen/Panel.hide()
#	$Area2D/CollisionShape2D_Cafe/Panel.hide()
	create_tables()
	create_cards()
	transition_screen_load()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if estado_atual == TimeState.RUNNING:
		time += delta
		if time > CLIENT_MIN_INTERVAL:
			aux_time += delta
			if aux_time > 1 and client_counter < client_limit:
				try_spawn()
				aux_time -= 1.0
			
		if time >= day_lenght:
			time = 0.0
			day_counter += 1
			transition_screen_load()
			estado_atual = TimeState.PAUSED

func create_tables():
	table_list.append(Table.new(Vector2(500,285)))
	table_list.append(Table.new(Vector2(335,285)))
	table_list.append(Table.new(Vector2(145,285)))

func create_cards():
	pass
#	card_list.append(Card.new(1, 1, 1, "Count Fang"))
#	card_list.append(Card.new(2, 0, 1, "Jujuba"))
#	card_list.append(Card.new(0, 0, 3, "Jiló"))

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
	client.global_position = self.position + Vector2(415,180)
	add_child(client)

func transition_screen_load():
	transition = transition_scene.instance()
	add_child(transition)

func day_manager():
	if day_counter == 1:
		if posso_prosseguir == 0:
			dialogo_atual = dialogue_list.dialogo_dia_1
			dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
			posso_prosseguir += 1
		else:
			if posso_prosseguir == 1:
				dialogo_atual = systemDia_list.sistema_dia_1
				dialogo_ou_sistema = 2
				dialogues.load_dialogue(dialogo_atual, dialogo_ou_sistema)
				estado_atual = TimeState.RUNNING
				posso_prosseguir += 1
