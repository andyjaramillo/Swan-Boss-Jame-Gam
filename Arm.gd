extends Area2D

var current_lives = 3
@export var speed = 150
var screen_size
var knife = preload("res://Knife.tscn")
signal hit
@export var knife_speed = 1000
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
func _physics_process(delta):
	if Input.is_action_just_pressed("shoot"):
		#call shoot knife method on A press
		shoot_knife()
	

func shoot_knife():
	var knife_instance = knife.instantiate()
	knife_instance.position = Vector2(global_position.x - 50,global_position.y/2)
	knife_instance.rotation_degrees = rotation_degrees
	knife_instance.linear_velocity = Vector2(0,- knife_speed)
	get_tree().get_root().call_deferred("add_child", knife_instance)
	$AnimatedSprite2D.set_frame_and_progress(1,0)
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.set_frame_and_progress(0,0)
	


func get_arm_lives():
	return current_lives

func reduce_arm_lives():
	current_lives = current_lives - 1

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	$AnimatedSprite2D.set_frame_and_progress(2,0)
	hit.emit()
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.set_frame_and_progress(0,0)
	pass # Replace with function body.

