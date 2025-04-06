extends Node2D

@export var slime_scene: PackedScene
@export var game_over_label: Label
@export var score_label: Label
@export var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = "score: " + str(score)
	

func add_score() -> void:
	score += 1

func game_over() -> void:
	$AudioStreamPlayer.play()
	game_over_label.visible = true

func _generate() -> void:
	var slime_node = slime_scene.instantiate()
	slime_node.position = Vector2(450, randf_range(91, 159))
	get_tree().current_scene.add_child(slime_node)
