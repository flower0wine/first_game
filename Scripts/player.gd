extends CharacterBody2D

@export var move_speed : int = 50
@export var animator: AnimatedSprite2D

@export var bullet_scene: PackedScene

var die: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not die:
		velocity = Input.get_vector("left", "right", "up", "down") * move_speed
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		move_and_slide()
		
	if velocity == Vector2.ZERO or die:
		$Running.stop()
	elif not $Running.playing:
		$Running.play()

func _die():
	if die:
		return
	animator.play("die")
	die = true
	
	get_tree().current_scene.game_over()
	$Timer2.start()


func _on_fire() -> void:
	if die:
		return
	$AudioStreamPlayer.play()
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(331, 57)
	get_tree().current_scene.add_child(bullet_node)


func _on_timer_2_timeout() -> void:
	get_tree().reload_current_scene()
