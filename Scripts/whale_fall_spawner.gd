extends StaticBody3D
const size = 1
const offset = 10

@onready var spawn_pool : Node3D = $"../Animals"
@onready var eelpout : PackedScene = preload("res://Scenes/eelpout_fixed.tscn")
@onready var grenadier : PackedScene = preload("res://Scenes/grenadier.tscn")



#spawn()
# given a spawn location and a scene to spawn, 
# will spawn the scene within the given range
# at a rate of spawnchance / 1000 per meter


func spawn_animal(spawn_location : Node3D, spawn_scene : PackedScene, x_range : float, y_range: float, z_range: float, spawn_chance) -> void: 
	var rng = RandomNumberGenerator.new()
	for x in range (-x_range, x_range, 1):
		for y in range (0, y_range, 1):
			for z in range (-z_range, z_range, 1):
				var random_number = rng.randf_range(0, 1000)
				if(random_number < spawn_chance):
					var new_scene = spawn_scene.instantiate()
					spawn_location.add_child(new_scene)
					new_scene.global_position = Vector3(position.x + x,position.y + y + offset, position.z + z)
					new_scene.rotation = Vector3(0, x + z, 0)







# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#spawn_animal(spawn_pool, eelpout, 7, 1, 3, 80)
	#spawn_animal(spawn_pool, grenadier, 7, 1, 3, 80)
	#spawn_animal(spawn_pool, eelpout, 40, 1, 40, 1)
	#spawn_animal(spawn_pool, grenadier, 40, 1, 40, 1)
	
	
	
