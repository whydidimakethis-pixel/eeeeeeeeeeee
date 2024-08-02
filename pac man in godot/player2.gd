extends CharacterBody2D


const speed = 100
var dir : Vector2




func _physics_process(_delta):
	velocity = dir * speed
	move_and_slide()


func _unhandled_input(_event: InputEvent):
	dir.x = Input.get_axis("a","d")
	dir.y = Input.get_axis("w", "s")
	dir - dir.normalized()
