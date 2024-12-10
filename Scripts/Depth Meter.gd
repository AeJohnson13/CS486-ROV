extends Label

const starting_depth = 2500 # meters

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var depth = starting_depth - $"../../../../..".position.y
	text = var_to_str(roundi(depth)) + " m" 
