extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	$AnimatedSprite2D.set_frame_and_progress(1,0)
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
