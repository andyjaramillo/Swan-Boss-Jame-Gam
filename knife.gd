extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Add signal for when leaving map

func _on_visible_on_screen_notifier_2d_screen_exited():
	#remove the knife if it leave
	queue_free()




func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$AnimatedSprite2D.set_frame_and_progress(1,0)
	$CollisionShape2D.set_deferred("disabled", true)
	linear_velocity = Vector2(0,0)
	await get_tree().create_timer(0.5).timeout
	queue_free()
