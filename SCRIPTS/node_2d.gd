extends Node2D

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D
@export var cam : Camera2D


func _ready():
	if cam:
		# Enable smoothing properly (Godot 4.3+)
		cam.set("smoothing.enabled", true)
		cam.set("smoothing.speed", 5.0)
		cam.set("smoothing.physic_step", true)  # syncs smoothing with physics to remove jitter


# ⚙️ Important: use _physics_process, not _process
func _physics_process(delta):
	# Flip sprite based on direction
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true

	# Determine animation based on velocity
	if player_controller.velocity.y < 0.0:
		animation_player.play("jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")
	elif abs(player_controller.velocity.x) > 0.0:
		animation_player.play("run")
	else:
		animation_player.play("idle")

	# Make camera follow smoothly in sync with physics
	if cam:
		cam.global_position = cam.global_position.lerp(player_controller.global_position, 0.15)
