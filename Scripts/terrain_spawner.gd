extends Node
var rng = RandomNumberGenerator.new()
const size = 1

@onready var terrain_Spawner : Node = $"."
@onready var terrain_scene : PackedScene = preload("res://Models/lawlorhead_10k.glb")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range (-50, 50, 5):
		for y in range (0, 50, 5):
			for z in range (-50, 50, 5):
				var random_number = rng.randf_range(0, 100)
				if(random_number < 20):
					var newhead = terrain_scene.instantiate()
					terrain_Spawner.add_child(newhead)
					newhead.global_position = Vector3(x, y, z)
					newhead.scale = Vector3.ONE * size * random_number
					newhead.rotation = Vector3(z, y, x)
				
		
