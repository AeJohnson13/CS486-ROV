extends Node2D
var change = 0.01
const starting_depth : float = 2500 # meters
const atmospheric_pressure_at_sea_level = 1 # atmosphere
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	
	var depth = starting_depth - $"../../../../..".position.y
	var pressure = atmospheric_pressure_at_sea_level + depth/10 # Atmosphere
	var to_print = roundi(pressure) #rounds to an integer
	$"../../Pressure Display".text = var_to_str(to_print) + " ATA"
	rotation = pressure/300 * (3.141)/2 - (3.141)/4 
	
	# -pi/4 to pi/4 
	#
	#rotation += change
	#if(abs(rotation)> 3.14/4):
		#change = -change
	#
