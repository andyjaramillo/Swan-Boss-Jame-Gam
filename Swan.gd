extends RigidBody2D

var bead = preload("res://bead.tscn")
var bead_speed = 2000
var lives = 10
signal hit
@export var isInHonkingState = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$BeadTimer.start()
	linear_velocity = Vector2(200,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.x >= 250:
		linear_velocity = Vector2(-200,0)
	if global_position.x <= -250:
		linear_velocity = Vector2(200,0)
		
		
func shoot_beads():
	var bead_one_instance = bead.instantiate()
	var bead_two_instance = bead.instantiate()
	var bead_three_instance = bead.instantiate()
	bead_one_instance.position = Vector2(global_position.x + 100, global_position.y+50)
	bead_two_instance.position =  Vector2(global_position.x + 100, global_position.y+50)
	bead_three_instance.position =  Vector2(global_position.x + 100, global_position.y+50)
	bead_one_instance.linear_velocity = Vector2(20, bead_speed).rotated(-0.5)
	bead_two_instance.linear_velocity = Vector2(0, bead_speed)
	bead_three_instance.linear_velocity = Vector2(-20, bead_speed).rotated(0.5)
	get_tree().get_root().call_deferred("add_child", bead_one_instance)
	get_tree().get_root().call_deferred("add_child", bead_two_instance)
	get_tree().get_root().call_deferred("add_child", bead_three_instance)
	

func get_swan_lives():
	return lives

func reduce_swan_lives():
	if isInHonkingState == false:
		lives = lives - 1
	if lives == 3:
		$HonkTimer.start()
		$AnimatedSprite2D.set_frame_and_progress(2,0)
		isInHonkingState = true

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if isInHonkingState == false:
		$AnimatedSprite2D.set_frame_and_progress(1,0)
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
		await get_tree().create_timer(0.5).timeout
		$CollisionShape2D.set_deferred("disabled", false)
		get_tree().create_timer(1).timeout
		$AnimatedSprite2D.set_frame_and_progress(0,0)
		# Must be deferred as we can't change physics properties on a physics callback.
		position.y=0
		linear_velocity = Vector2(linear_velocity.x,0)
	


func _on_bead_timer_timeout():
	shoot_beads()
	$BeadTimer.start()


func _on_honk_timer_timeout():
	isInHonkingState = false
	$AnimatedSprite2D.set_frame_and_progress(0,0)
	await get_tree().create_timer(2).timeout
	$AnimatedSprite2D.set_frame_and_progress(2,0)
	isInHonkingState = true
	$HonkTimer.start()
