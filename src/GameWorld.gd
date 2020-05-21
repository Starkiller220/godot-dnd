extends Node2D

onready var map :TileMap = $TileMap
onready var noise: OpenSimplexNoise = OpenSimplexNoise.new()
	
export var width  = 50
export var height = 50

var rng = RandomNumberGenerator.new()
var prev:Vector2 = Vector2(0,0)

enum TILES{GRASS,WATER,STONE,SAND,SNOW}

func _ready():
	randomize()

	noise.seed = randi()
	noise.octaves = 3
	noise.period = 5
	noise.lacunarity = 0.25
	noise.persistence = 1.75

	_generate_world(0,0)

	
func _generate_world(offx,offy):
	
	for x in range(offx,width+offx):
		for y in range(offy,width+offy):
			map.set_cellv(Vector2(x - width / 2,y - height /2),_get_tile(noise.get_noise_2d(float(x),float(y))))

func _get_tile(sample):
	sample *=100
	if sample < -45:
		return TILES.SNOW
	if sample < -35:
		return TILES.STONE
	if sample < 0:
		return TILES.GRASS
	if sample < 4:
		return TILES.SAND	
	else:
		return TILES.WATER


func _on_MainCamera_moved(vector):
	vector = Vector2(vector.x/(64),vector.y/(50))
#	print(prev)
#	for x in range(int(vector.x) if int(vector.x) < 0 else int(prev.x)+width,int(prev.x) if vector.x < 0 else int(vector.x)+width):
#		for y in range(int(vector.y),int(prev.y)+height):
#			map.set_cellv(Vector2(x - width / 2,y - height / 2),_get_tile(noise.get_noise_2d(float(x),float(y))))
#
#	for y in range(int(vector.y) if int(vector.y) > 0 else int(prev.y)+height,int(prev.y) if vector.y > 0 else int(vector.y)+height):
#		for x in range(int(vector.x),int(prev.x)+width):
#			map.set_cellv(Vector2(x - width / 2,y - height / 2),_get_tile(noise.get_noise_2d(float(x),float(y))))
	
	for x in range(prev.x,width+prev.x):
		for y in range(prev.y,width+prev.y):
			map.set_cellv(Vector2(x - width / 2,y - height /2),-1)
	
	_generate_world(vector.x,vector.y)
	
	
#	for x in range(int(prev.x),int(prev.x)+width):
#		for y in range(int(vector.y),int(prev.y)+height):
#			map.set_cellv(Vector2(x - width / 2,y - height / 2),-1)
	
	
	prev = vector
