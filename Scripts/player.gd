extends CharacterBody2D

const TILE_SIZE := 32

var move_tween: Tween

func _physics_process(delta: float) -> void:
	if !move_tween or !move_tween.is_running():
		if Input.is_action_pressed("up") and !$MoveRayUp.is_colliding():
			move(Vector2i(0, -1))
		elif Input.is_action_pressed("left") and !$MoveRayLeft.is_colliding():
			move(Vector2i(-1, 0))
		elif Input.is_action_pressed("down") and !$MoveRayDown.is_colliding():
			move(Vector2i(0, 1))
		elif Input.is_action_pressed("right") and !$MoveRayRight.is_colliding():
			move(Vector2i(1, 0))


func move(dir: Vector2) -> void:
	if move_tween: 
		move_tween.kill()
	move_tween = create_tween()
	move_tween.tween_property(self, "position", position + dir * TILE_SIZE, 0.15).set_trans(Tween.TRANS_SINE)
