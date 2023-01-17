extends Node

signal jump

onready var label = Utils.get_main_node().get_node("HUD/uifb")
onready var camera = Utils.get_main_node().get_node("KineBall/Camera")
# this is a hack for mobile

#onready var dim = camera.get_viewport_rect().size


func _input(event):
	#var label = Utils.get_main_node().get_node("HUD/uifb")
	if (event is InputEventMultiScreenDrag or
	event is InputEventMultiScreenSwipe or
	event is InputEventMultiScreenTap or
	event is InputEventMultiScreenLongPress or
	event is InputEventSingleScreenDrag or
	event is InputEventScreenPinch or
	event is InputEventSingleScreenTap or
	event is InputEventSingleScreenLongPress or
	event is InputEventSingleScreenTouch or
	event is InputEventSingleScreenSwipe or
	event is InputEventSingleScreenDrag):
		print(event.as_text())
		#label.text = event.as_text().replace('|','\n')

	
	if event is InputEventMultiScreenDrag:
		label.text = "jump"
		emit_signal("jump")
	if event is InputEventSingleScreenDrag:
		label.text = "drag"
		#print(event.as_text().replace('|','\n') )
	if event is InputEventSingleScreenTap:
		label.text = "finger tap"
		emit_signal("jump")

# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
