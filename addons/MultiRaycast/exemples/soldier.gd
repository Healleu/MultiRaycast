extends CharacterBody2D

var speed = 400  # move speed in pixels/sec
var rotation_speed = 1.5  # turning speed in radians/sec

func _physics_process(delta):
	var move_input = Input.get_axis("ui_down", "ui_up")
	var rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = transform.x * move_input * speed
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	return


func _on_multi_raycast_2d_colliding(state : bool, colliders : Array[PhysicsBody2D]) -> void :
	if state : 
		for collider in colliders :
			if collider.is_in_group("Enemy") :
				$CanvasLayer/Label.set_visible(true)
	else :
		$CanvasLayer/Label.set_visible(false)
	return
