
extends Camera2D

var x = Vector2()
const speed = 200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass
	
func _process(delta):
#	if Input.is_action_pressed("move_cam_l"):
#		x += Vector2 ( -1 , 0 )
#	elif Input.is_action_pressed("move_cam_r"):
#		x += Vector2 (1,0)
	if Input.is_action_pressed("move_cam_d"):
		x += Vector2 (0,1)
	elif Input.is_action_pressed("move_cam_u"):
		x += Vector2(0,-1)
	else :
		x = Vector2(0,0)

	var pos = get_pos()
	pos += x*delta*speed
	set_pos(pos)
	


