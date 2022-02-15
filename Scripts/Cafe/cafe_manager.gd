extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0.0
var aux_time = 0.0
var rng = RandomNumberGenerator.new()
var client_counter = 0
var client_limit = 3
var table_list = []

const CLIENT_MIN_INTERVAL = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	create_tables()
	print(table_list[2].position)
	print(table_list[2].occupied)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > CLIENT_MIN_INTERVAL:
		aux_time += delta
		if aux_time > 1 and client_counter < client_limit:
			try_spawn()
			aux_time -= 1.0

func create_tables():
	table_list.append(Table.new(Vector2(500,285)))
	table_list.append(Table.new(Vector2(335,285)))
	table_list.append(Table.new(Vector2(145,285)))

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
	
