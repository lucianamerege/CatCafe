extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time = 0.0
var aux_time = 0.0
var rng = RandomNumberGenerator.new()
var client_counter = 0
var table_list = 0

const CLIENT_MIN_INTERVAL = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time > CLIENT_MIN_INTERVAL:
		aux_time += delta
		if aux_time > 1:
			try_spawn()
			aux_time -= 1.0

func try_spawn():
	var chance = time/2
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
	client.global_position = self.position + Vector2(16,8)
	print("cliente " + str(client_counter) + " spawnou em" + str(client.global_position))
	
