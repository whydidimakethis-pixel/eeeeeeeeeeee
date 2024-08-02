extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d2 = $Sprite2D2



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 200


func _physics_process(delta):
	# Add the gravity.
	if (velocity.x > 1 or velocity.x < -1):
		sprite_2d2.animation = "running"
	else:
		sprite_2d2.animation = "default"

	
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
		sprite_2d2.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("w") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 13)

	move_and_slide()
	
	
	
	
	var isLeft = velocity.x < 0
	sprite_2d2.flip_h = isLeft


func _on_area_2d_area_entered(area):
	if area.is_in_group("saw 1"):
		position.x = 27
		position.y = 300
	if area.is_in_group("l2"):
		Globalvariables.p2complete = true
		if Globalvariables.p1complete:
			Globalvariables.level +=1
			Globalvariables.p2complete = false
			Globalvariables.p1complete = false
			get_tree().change_scene_to_file("res://level "+str(Globalvariables.level)+".tscn")
		call_deferred("_remove_collision_object",area)

func _remove_collision_object(area):
	if area.name == "p2_col":
		area.queue_free()
		
		
		


func _on_p_2_col_area_exited(area):
	if area.is_in_group("l2"):
		Globalvariables.p2complete = false
		print("player 2 exited")
