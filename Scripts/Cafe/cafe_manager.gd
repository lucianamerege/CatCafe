extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const day_lenght = 10.0

var time = 0.0
var aux_time = 0.0
var rng = RandomNumberGenerator.new()
var client_counter = 0
var client_limit = 3
var table_list = []
var card_list = []
var order_queue = []
var money = 1000
var day_counter = 1

const CLIENT_MIN_INTERVAL = 3.0

onready var dialogues = $TextBox

enum TimeState {
	RUNNING,
	PAUSED
}

var estado_atual = TimeState.RUNNING

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogues.hide_textbox()
	create_tables()
	create_cards()
	print(table_list[2].position)
	print(table_list[2].occupied)
	print(card_list[2].nome)


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
			print("Fim do dia "+str(day_counter))
			time = 0.0
			day_counter += 1
			estado_atual = TimeState.PAUSED
			call_textbox()

func create_tables():
	table_list.append(Table.new(Vector2(500,285)))
	table_list.append(Table.new(Vector2(335,285)))
	table_list.append(Table.new(Vector2(145,285)))

func create_cards():
	card_list.append(Card.new(1, 1, 1, "Count Fang"))
	card_list.append(Card.new(2, 0, 1, "Jujuba"))
	card_list.append(Card.new(0, 0, 3, "Jiló"))

func try_spawn():
	var chance = time/2 * (client_limit - client_counter) * 1.5/client_limit
	print("tento spawnar")
	var value = rng.randi_range(1,100)
	if value < chance:
		print("consegui com chance" + str(chance) +" e rng"+ str(value))
		spawn_client()
		time = 0.0
		
	
func spawn_client():
	client_counter += 1
	var client_path = "res://Scenes/Entity/Client.tscn"
	var client = load(client_path).instance()
	client.global_position = self.position + Vector2(415,180)
	print("cliente " + str(client_counter) + " spawnou em" + str(client.global_position))
	add_child(client)
	
func call_textbox():
	dialogues.load_dialogue()
