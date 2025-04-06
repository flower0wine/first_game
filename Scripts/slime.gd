extends Area2D

@export var move_speed: int = -50
@export var animator: AnimatedSprite2D

var die: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if die:
		return
	position += Vector2(move_speed, 0) * delta
	
	if position.x < -373:
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not die:
		body._die()


func _die() -> void:
	die = true
	animator.play("die")
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.6).timeout
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("Bullet"):
		return
	
	area.queue_free()
	get_tree().current_scene.add_score()
	_die()
