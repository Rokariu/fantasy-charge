extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if 	body.name == "Hero":
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", Vector2(0, 25), 0.3)
		tween.tween_callback(queue_free)
		body.gold += 1
		 
