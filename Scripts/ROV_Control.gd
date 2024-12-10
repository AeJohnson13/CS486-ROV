extends RigidBody3D
const thrust_strength : float = 1400.0           # Newtons
const drag_coefficient : float = 1.05            # Unitless only applies to a square cross section
const volume : float = 2.5                       # m^3 
const front_area : float = 4                     # m^2
const side_area : float = 8                      # m^2
const water_density : float = 999                # kg/m^3
const gravity = Vector3(0,-9.8,0)                # N 
const rotation_thrust : float = 200.0            # Newtons
var debug_force_scale = 1.0                    # Unitless 
var mmb_pushed : bool = false
var mouse_position = Vector2(0,0)
# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func get_linear_thrust():
	################################################### ROV Linear Movement ##############################################################
	var ad : float = 0   # left right control
	var ws : float = 0   # forward backward control
	var sc : float = 0   # up down control
	 
	
	if (Input.is_action_pressed("Go_left")): # move left 
		ad = -1 
	if (Input.is_action_pressed("Go_right")): # move right 
		ad = 1


	if (Input.is_action_pressed("Go_forward")):
		ws = 1
	if (Input.is_action_pressed("Go_backward")):
		ws = -1


	if (Input.is_action_pressed("Go_up")):
		sc = 1 
	if (Input.is_action_pressed("Go_down")):
		sc = -1
			
		
	var force = Vector3(ws,sc,ad)
	
	return debug_force_scale * thrust_strength * force
	
	
	
	
	################################################### ROV Angular Movement ##########################################
func get_angular_thrust():
	var yaw : float = 0   # yaw control 
	var pitch : float = 0 # pitch control
	var roll : float = 0 # roll control 
	
	const deadzone : float = 50
	
	if(Input.is_action_just_pressed("Rotation Button")):
		mmb_pushed = true 
		mouse_position = get_viewport().get_mouse_position()
	if(Input.is_action_just_released("Rotation Button")):
		mmb_pushed = false 
	
	if(mmb_pushed):
		var location = get_viewport().get_mouse_position()
		if (location.x > mouse_position.x && abs(location.x-mouse_position.x) > deadzone):  # turn right
			yaw = -1
		elif (location.x < mouse_position.x && abs(location.x-mouse_position.x) > deadzone): # turn left 
			yaw = 1
		if (location.y > mouse_position.y && abs(location.y-mouse_position.y) > deadzone): # pitch down 
			pitch = -1
		elif (location.y < mouse_position.y && abs(location.y-mouse_position.y) > deadzone): # pitch up  
			pitch = 1
	#
	if (Input.is_action_pressed("Spin_left")): # roll c-clockwise
		roll = -1
	if (Input.is_action_pressed("Spin_right")): # roll clockwise
		roll = 1
	
	return debug_force_scale * Vector3(rotation_thrust * roll, rotation_thrust * yaw, rotation_thrust * pitch)
		
		
		
		
		
	######################################################### fluid drag #############################################
func get_linear_drag():
	return (0.5) * (water_density) * (linear_velocity) * (front_area) * (drag_coefficient)
func get_angular_drag():	
	return (0.5) * (water_density) * (angular_velocity) * (front_area) * (drag_coefficient)
	
	
	######################################################### buoyancy #############################################
func get_vertical_physics():
	var buoyant_force = -water_density * gravity * volume
	var gravity_force = mass * gravity
	return buoyant_force + gravity_force
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var linear_thrust = get_linear_thrust()
	var vertical_physics = get_vertical_physics()
	var linear_drag = get_linear_drag()
	var angular_thrust = get_angular_thrust() 
	var angular_drag = get_angular_drag()
	var globalized_linear_thrust = global_transform.basis * linear_thrust
	var globalized_angular_thrust = global_transform.basis * angular_thrust
	####################################################### apply forces ###################################################
	constant_force =  globalized_linear_thrust + vertical_physics - linear_drag
	constant_torque = globalized_angular_thrust- angular_drag
	
	####################################################### debug ###################################################
	
	if Input.is_action_just_pressed("Speed Boost"):
		debug_force_scale = 20 
	elif Input.is_action_just_released("Speed Boost"):
		debug_force_scale = 1 
		
		
		
	
	
	
