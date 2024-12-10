extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	var exit_button = %Yes
	exit_button.pressed.connect(self.exit_button_pressed)
	var continue_button = %No
	continue_button.pressed.connect(self.continue_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_pressed("Escape")):
		Engine.time_scale = 0
		visible = true
	

func exit_button_pressed():
	get_tree().quit()
func continue_button_pressed():
	Engine.time_scale = 1
	visible = false
