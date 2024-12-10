extends Control

@onready var whale_scene : PackedScene = load("res://Scenes/whale_fall_level.tscn")

func _ready():
	var start_button = %StartButton
	start_button.pressed.connect(self.start_button_pressed)
	var exit_button = %ExitButton
	exit_button.pressed.connect(self.exit_button_pressed)

func start_button_pressed():
	var new_level = whale_scene.instantiate()
	#add_child(new_level)
	get_tree().change_scene_to_packed(whale_scene)
	$Background.hide()

func exit_button_pressed():
	get_tree().quit()
