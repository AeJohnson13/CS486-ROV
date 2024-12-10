extends AnimationPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	play("ArmatureAction")
	if($"..".rotation.x > 20 or $"..".rotation.x < -20):
		print_debug("righting fish")
		if($"..".rotation.x > 20):
				$"..".rotation.x -= 1
		if($"..".rotation.x < -20):
				$"..".rotation.x += 1
