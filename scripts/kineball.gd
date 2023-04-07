extends KinematicBody

onready var label = Utils.get_main_node().get_node("HUD/uifb")


var vec_pos = Vector3(0,0,0) 
var speed = 20
var rotspeed= 9
var gravity= -5
var jump_force = 120

# swipe vectors 
#        "swipe_up"         : Vector2.UP,
#        "swipe_up_right"   : Vector2.UP + Vector2.RIGHT,
#        "swipe_right"      : Vector2.RIGHT,
#        "swipe_down_right" : Vector2.DOWN + Vector2.RIGHT,
#        "swipe_down"       : Vector2.DOWN,
#        "swipe_down_left"  : Vector2.DOWN + Vector2.LEFT,
#        "swipe_left"       : Vector2.LEFT,
#        "swipe_up_left"    : Vector2.UP + Vector2.LEFT



func _ready():
	#var label = Utils.get_main_node().get_node("HUD/uifb")
	var world = get_parent()
	world.connect("jump", self, "_on_jump")

#	global_transform.origin = get_parent().get_node("spawn test position").global_transform.origin
	pass	
	
func _unhandled_input(event):
	#if event is InputEventScreenTouch:
	#	var a = InputEventAction.new()
	#	a.action = "jump"
	#	a.pressed = false
	#	Input.parse_input_event(a)
	pass
	
func _input(event):
	
	#var label = Utils.get_main_node().get_node("HUD/uifb")
	if event is InputEventScreenDrag:
		if event.relative[0] > 0:
			#print(event.relative)
			vec_pos.x=1
			$ballMesh.rotate_z(deg2rad(-rotspeed))
		elif event.relative[0] < 0:
			vec_pos.x=-1
			$ballMesh.rotate_z(deg2rad(rotspeed))
		else:
			vec_pos.x= lerp(vec_pos.x,0,0.2)
			
		if event.relative[1] < 0:
			vec_pos.z=-1
			$ballMesh.rotate_x(deg2rad(-rotspeed))
		elif event.relative[1] > 0:
			vec_pos.z=1
			$ballMesh.rotate_x(deg2rad(rotspeed))
		else:
			vec_pos.z= lerp(vec_pos.z,0,0.2) 

	vec_pos.y += gravity
	
	if (event is InputEventScreenTouch):
		if (event.index > 0):
			vec_pos.y = jump_force
		#print(event.index)

			
	vec_pos = move_and_slide(vec_pos,Vector3.UP)
		
func _physics_process(_delta):

	if Input.is_action_pressed("right") and Input.is_action_pressed("left"):
		vec_pos.x=0
	elif Input.is_action_pressed("right"):
		vec_pos.x=speed
		$ballMesh.rotate_z(deg2rad(-rotspeed))
	elif Input.is_action_pressed("left"):
		vec_pos.x=-speed
		$ballMesh.rotate_z(deg2rad(rotspeed))
	else:
		vec_pos.x= lerp(vec_pos.x,0,0.2)
		
	if Input.is_action_pressed("up") and Input.is_action_pressed("down"):
		vec_pos.z=0
	elif Input.is_action_pressed("up"):
		vec_pos.z=-speed
		$ballMesh.rotate_x(deg2rad(-rotspeed))
	elif Input.is_action_pressed("down"):
		vec_pos.z=speed
		$ballMesh.rotate_x(deg2rad(rotspeed))
	else:
		vec_pos.z= lerp(vec_pos.z,0,0.2) 
		
	vec_pos.y += gravity
	
	if Input.is_action_pressed("jump") and is_on_floor():
		vec_pos.y = jump_force
			
	vec_pos = move_and_slide(vec_pos,Vector3.UP)


func _on_Abyss_body_entered(body):
	if body.name == "KineBall":
		get_parent().get_node("Sounds/hurt").play()
		$Timer2.start()


func _on_Enemy_body_entered(body):
	if body.name == "KineBall":
		get_parent().get_node("Sounds/hurt").play()
		$Timer2.start()


func _on_finish_area_body_entered(body):	
	get_parent().get_node("Sounds/win").play()
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Control.tscn")


func _on_Timer2_timeout():
	get_tree().change_scene("res://scenes/Level.tscn")

# signal from Level/world
func _on_jump():
	vec_pos.y = jump_force
	vec_pos = move_and_slide(vec_pos,Vector3.UP)


func _on_Coin_cn_collected():
	get_parent().get_node("Sounds/coinsnd").play()


func _on_t1_body_entered(body):
	if body.name == "KineBall":
		get_parent().get_node("Doors/door1/door1animp").play("d1animp")
#		
		var material = get_parent().get_node("triggers/t1/MeshInstance").get_surface_material(0)
		material.albedo_color = Color("14ff00")
		get_parent().get_node("triggers/t1/MeshInstance").set_surface_material(0, material)
		
		get_parent().get_node("triggers/t1").set_collision_layer_bit(0,false)
		get_parent().get_node("triggers/t1").set_collision_mask_bit(0,false)
		


func _on_t2_body_entered(body):
	get_parent().get_node("Doors/door2/leftside/AnimationPlayer").play("d2lsanimp")
	get_parent().get_node("Doors/door2/rightside/AnimationPlayer").play("d2rsanimp")
	
	var material = get_parent().get_node("triggers/t2/MeshInstance").get_surface_material(0)
	material.albedo_color = Color("14ff00")
	get_parent().get_node("triggers/t2/MeshInstance").set_surface_material(0, material)
	
	get_parent().get_node("triggers/t2").set_collision_layer_bit(0,false)
	get_parent().get_node("triggers/t2").set_collision_mask_bit(0,false)
