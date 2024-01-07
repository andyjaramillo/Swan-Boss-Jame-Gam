extends CanvasLayer

var frame_progress = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass

func update_butcher_lives(lives):
	$AnimatedSprite2D.set_frame_and_progress(lives,0)




func _on_arm_hit():
	frame_progress = frame_progress + 1
	$ButcherLives.set_frame_and_progress(frame_progress,0)
