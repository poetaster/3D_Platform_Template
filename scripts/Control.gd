extends Control

onready var label = $Label

func _ready():
	pass 


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Level.tscn")



func _on_Button_button_up():
	get_tree().change_scene("res://scenes/Level.tscn")

