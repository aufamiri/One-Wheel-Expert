
extends RigidBody2D
var score = 0
var pos = Vector2(0,0)
var player = Vector2()
var grid
var onfloor = false
var time
var test = false
var partpos = Vector2()

func _ready():
	set_process(true)
	get_tree().set_pause(true)
	pass
	
func _integrate_forces(state):
	var leanL = Input.is_action_pressed("leanL")
	var leanR = Input.is_action_pressed("leanR")
	var gas = Input.is_action_pressed("gas")
	var jump = Input.is_action_pressed("jump")
	var step = state.get_step()
	var speed = state.get_linear_velocity()
	var jumping  = true
	var crash = false
	var found_floor = false
	var floor_index = -1

	for x in range(state.get_contact_count()):
		var ci = state.get_contact_local_normal(x)
		if (ci.dot(Vector2(0, -1)) > 0.6):
			found_floor = true
			floor_index = x
		
	if (state.get_contact_count() > 2):
		get_tree().set_pause(true)
		get_node("explode").set_emitting(true)
		get_node("../over/over").show()
		get_node("../over/restart").show()
		get_node("../hud/Score").hide()
		get_node("../hud/text").hide()
		get_node("..").game_over()

	if (leanL):
		state.set_angular_velocity(2)
	if (leanR):
		state.set_angular_velocity(-2)
	if (jumping):
		if ( speed.y > 0):
			jumping = false
	if (onfloor):
		if (gas):
			speed.x += 400*step
		if (not jumping and jump):
			speed.y = -200
			jumping = true
			onfloor = false
	if (gas and not onfloor):
		speed.x += 100*step

	speed += state.get_total_gravity()*step
	state.set_linear_velocity(speed)
	print (state.get_contact_count())
	pass


func _process(delta):
	player = get_pos()
	time = get_node("../start").get_time_left()
	grid = get_node("../level").world_to_map(player)
	score = grid.x
	get_node("../hud/text").set_text(str(score))
	get_node("../hud/time").set_text(str(int(time + 1)))

func _on_wheel_body_enter( body ):
	onfloor = true
	pass # replace with function body


func _on_play_pressed():
	get_node("../start").start()
	get_node("../anim").play("fade")
	get_node("../hud/time").show()
	pass # replace with function body


func _on_quit_pressed():
	get_tree().quit()
	pass # replace with function body


func _on_start_timeout():
	get_tree().set_pause(false)
	get_node("../start").stop()
	get_node("../hud/time").hide()
	get_node("../hud/Score").show()
	get_node("../hud/text").show()
	pass # replace with function body


func _on_hit_body_enter( body ):
	test = true
	pass # replace with function body


func _on_hit_area_enter( area ):
	test = true
	pass # replace with function body


func _on_restart_pressed():
	get_tree().change_scene("res://Scene/level.scn")
	pass # replace with function body
