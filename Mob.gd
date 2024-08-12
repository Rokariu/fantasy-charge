extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
 
var speed = 100
var chase = false
@onready var anim = $AnimatedSprite2D
var alive = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var Hero = $"../Hero/Hero"
	var direction = (Hero.position - self.position).normalized()
	if alive == true:
		if chase == true:
			velocity.x = direction.x * speed
			anim.play("Run")
		else:
			velocity.x = 0
			anim.play("Idle")
			
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	move_and_slide()

func _on_agrozone_body_entered(body):
	if body.name == "Hero":
		chase = true


func _on_agrozone_body_exited(body):
	if body.name == "Hero":
		chase = false


func _on_death_body_entered(body):
	if body.name == "Hero":
		body.velocity.y -= 300
		death()
				
func _on_death_2_body_entered(body):	
	if body.name == "Hero":
		if alive == true:
			body.health -= 20
		death()	
			
			
func death ():	
	alive = false
	anim.play("Death")
	await anim.animation_finished
	queue_free()
