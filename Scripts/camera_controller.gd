extends Node3D


@onready var Forward_Camera = $Forward_Camera
@onready var Down_Camera = $Down_Camera
var rotation_button_pushed : bool = false
var mouse_position 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Down_Camera.clear_current(true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Switch Cameras")):
		if (Forward_Camera.is_current()):
			Forward_Camera.clear_current(true)
		elif (Down_Camera.is_current()):
			Down_Camera.clear_current(true)
			
	
