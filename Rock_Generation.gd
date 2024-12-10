@tool
extends StaticBody3D

@export var xWidth = 256
@export var zWidth = 256
@export var noiseScaleLight = 6
@export var noiseScaleHeavy = 23 

@onready var terrainMesh : MeshInstance3D = $"Rock Mesh"
@onready var terrainColider : CollisionShape3D = $"Rock Collision"
@export var terrainTexture : StandardMaterial3D

@export var noiseTextureOne : FastNoiseLite = FastNoiseLite.new()
@export var noiseTextureTwo : FastNoiseLite = FastNoiseLite.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	makeTerrainMesh(xWidth, zWidth)
	
func makeTerrainMesh(xSize:int, zSize:int):
	
	
	var arrayMesh : ArrayMesh
	var collisionArray : PackedFloat32Array =[]
	var surftool =SurfaceTool.new()
	
	surftool.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	for z in range(zSize+1):
		for x in range(xSize+1):
			var y = noiseTextureOne.get_noise_2d(x,z) * noiseScaleLight
			y += noiseTextureTwo.get_noise_2d(x,z) * noiseScaleHeavy
			
			collisionArray.push_back(y)
			
			var uv = Vector2()
			uv.x = inverse_lerp(0, xSize, x)
			uv.y = inverse_lerp(0, zSize, z)
			surftool.set_uv(uv)
			surftool.add_vertex(Vector3(x, y, z))
			
	

	arrayMesh = surftool.commit()
	
	
	var currentVertex = 0
	for z in zSize:
		for x in xSize:
			surftool.add_index(currentVertex + 0)
			surftool.add_index(currentVertex + 1)
			surftool.add_index(currentVertex + xSize + 1)
			surftool.add_index(currentVertex + xSize + 1)
			surftool.add_index(currentVertex + 1)
			surftool.add_index(currentVertex + xSize + 2)
			currentVertex += 1
		currentVertex += 1
	
	
	surftool.generate_normals()
	arrayMesh = surftool.commit()
	terrainMesh.mesh = arrayMesh
	terrainMesh.set_surface_override_material(0,terrainTexture)
	terrainColider.shape.set_map_data(collisionArray)
	
