
extends Node

# member variables here, example:
# var a=2
# var b="textvar"
var max_score = 0
func _ready():
	var f = File.new()
	# Load high score
	if (f.open("user://maxscore", File.READ) == OK):
		max_score = f.get_var()
	get_node("menu/score").set_text(str(max_score))


func game_over():
	if (get_node("player").score > max_score):
		max_score = get_node("player").score
		# Save high score
		var f = File.new()
		f.open("user://maxscore", File.WRITE)
		f.store_var(max_score)