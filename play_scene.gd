extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func game_over():
	get_tree().change_scene_to_file("res://end_scene.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Swan.get_swan_lives() == 0 or $Arm.get_arm_lives() == 0:
		game_over()


func _on_swan_hit():
	$Swan.reduce_swan_lives()


func _on_arm_hit():
	$Arm.reduce_arm_lives()
