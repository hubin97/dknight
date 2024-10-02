extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	game_manager.pickup_coin()
	animation_player.play('pickup')
	
