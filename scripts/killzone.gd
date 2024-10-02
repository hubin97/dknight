extends Area2D

# 注意 危险区域 不添加形状节点， 这样外部可以方便自定义 

@onready var timer = $Timer

func _on_body_entered(_body):
	timer.start()


func _on_timer_timeout():
	print('重启主场景')
	get_tree().reload_current_scene()
