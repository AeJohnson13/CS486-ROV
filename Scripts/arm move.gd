extends Skeleton3D

enum BoneNum { 
	Root = 0 , Base, Base_Hinge, Long_Arm, Short_Arm_Bend, Long_Arm_Bend, Short_Arm, Hand, Right_Finger, Left_Finger
}

# didn't check to see if this was built in
const degreeTOradian = (2*PI)/180
const rotation_rate = 0.5

#starting values
const root_rotation = 45 * degreeTOradian # keeps upright
var base_rotation = 45 * degreeTOradian
var long_arm_rotation = -0.7 
var bended_arm_rotation = 1.7
var short_arm_rotation = 0
var hand_rotation = 0 
var use_long_arm : bool = true

#rotation constraints
const base_rotation_limits =       Vector2(0.3,2.8)
const long_arm_rotation_limits =   Vector2(-0.7,0)
const bended_arm_rotation_limits = Vector2(0.4, 1.7) 
const short_arm_rotation_limits =  Vector2(-1.5, 1.5)
const hand_rotation_limits =       Vector2(-1.5, 1.5) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var ad : float = 0 
	var ws : float = 0 
	var alt_ad : float = 0 
	var alt_ws : float = 0 


	if (Input.is_action_pressed("Arm Base Left")):
		ad = rotation_rate
	elif (Input.is_action_pressed("Arm Base Right")):
		ad = -rotation_rate
	
	if (Input.is_action_pressed("Arm Forward")):
		ws = rotation_rate
	elif (Input.is_action_pressed("Arm Backward")):
		ws = -rotation_rate 
	
	if (Input.is_action_pressed("Hand_Left")):
		alt_ad = -rotation_rate
	elif (Input.is_action_pressed("Hand_Right")):
		alt_ad = rotation_rate
	
	if (Input.is_action_pressed("Hand_Up")):
		alt_ws = -rotation_rate
	elif (Input.is_action_pressed("Hand_Down")):
		alt_ws = rotation_rate 
	
	if (use_long_arm):
		long_arm_rotation   += degreeTOradian * ws
	else:
		bended_arm_rotation -= degreeTOradian * ws
		
	base_rotation       += degreeTOradian * ad
	short_arm_rotation  += degreeTOradian * alt_ws
	hand_rotation       += degreeTOradian * alt_ad
	
	
	
	long_arm_rotation = clamp(long_arm_rotation, long_arm_rotation_limits.x, long_arm_rotation_limits.y)
	bended_arm_rotation = clamp(bended_arm_rotation, bended_arm_rotation_limits.x, bended_arm_rotation_limits.y)
	base_rotation = clamp(base_rotation, base_rotation_limits.x, base_rotation_limits.y)
	short_arm_rotation = clamp(short_arm_rotation, short_arm_rotation_limits.x, short_arm_rotation_limits.y)
	hand_rotation = clamp(hand_rotation, hand_rotation_limits.x, hand_rotation_limits.y)
	
	
	if(use_long_arm && long_arm_rotation == long_arm_rotation_limits.y && ws == rotation_rate):
		use_long_arm = false
	if(!use_long_arm && bended_arm_rotation == bended_arm_rotation_limits.y && ws == -rotation_rate):
		use_long_arm = true
	
	
	set_bone_pose_rotation (BoneNum.Root,           Quaternion(Vector3(1,0,0), root_rotation))
	set_bone_pose_rotation (BoneNum.Base,           Quaternion(Vector3(0,1,0), base_rotation))
	set_bone_pose_rotation (BoneNum.Long_Arm,       Quaternion(Vector3(1,0,0), long_arm_rotation))
	set_bone_pose_rotation (BoneNum.Short_Arm_Bend, Quaternion(Vector3(1,0,0), bended_arm_rotation))
	set_bone_pose_rotation (BoneNum.Short_Arm,      Quaternion(Vector3(1,0,0), short_arm_rotation))
	set_bone_pose_rotation (BoneNum.Hand,           Quaternion(Vector3(0,0,1), hand_rotation))
	
	#print_debug(bended_arm_rotation)
	
