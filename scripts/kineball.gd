extends KinematicBody



var vec_pos = Vector3(0,0,0) 
var speed = 20
var rotspeed= 9
var gravity= -5
var jump_force = 120



func _ready():
	pass

func _physics_process(_delta):
	if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left"):
		vec_pos.x=0
	elif Input.is_action_pressed("ui_right"):
		vec_pos.x=speed
		$ballMesh.rotate_z(deg2rad(-rotspeed))
	elif Input.is_action_pressed("ui_left"):
		vec_pos.x=-speed		
		$ballMesh.rotate_z(deg2rad(rotspeed))
	else:
		vec_pos.x= lerp(vec_pos.x,0,0.2)
		
	if Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_down"):
		vec_pos.z=0
	elif Input.is_action_pressed("ui_up"):
		vec_pos.z=-speed
		$ballMesh.rotate_x(deg2rad(-rotspeed))
	elif Input.is_action_pressed("ui_down"):
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
		get_tree().change_scene("res://scenes/Level.tscn")


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





func _on_Coin_cn_collected():
	get_parent().get_node("Sounds/coinsnd").play()
