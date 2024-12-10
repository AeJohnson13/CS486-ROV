@tool
extends Node3D

@export var spotlight_range = 100 
@export var spotlight_attenuation = 2
@export var spotlight_angle = 60
@export var spotlight_angle_attenuation = 1.0
@export var spotlight_color : Color
@export var spotlight_energy = 1.0

@onready var lights =  [$"Light Can 2/Spotlight 1",$"Light Can/Spotlight 2",$"Light Can 3/Spotlight 3",$"Light Can 4/Spotlight 4"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(property_list_changed):
		for x in lights:
			x.spot_range = spotlight_range
			x.spot_attenuation = spotlight_attenuation
			x.spot_angle = spotlight_angle
			x.spot_angle_attenuation = spotlight_angle_attenuation
			x.light_color = spotlight_color
			x.light_energy = spotlight_energy
