
extends TileMap

var y = 7
var x = 9
var yt = 6
var ya = 7
var rand
var a
var pos = Vector2()
var grid
var cell

func _ready():
	set_process(true)
	pass

func _process(delta):
	randomize()
	if  y < ya + 4 :
		set_cell(x,y,get_tileset().find_tile_by_name("dirt"))
		y += 1

	else :
		x += 1
		rand = randi () % 31
		if rand < 11 :
			ya -= 1
			set_cell(x - 1,ya - 1,get_tileset().find_tile_by_name("up"))
			set_cell(x - 1,ya,get_tileset().find_tile_by_name("dirt"))
			set_cell(x, ya -1, get_tileset().find_tile_by_name("top"))
		
		elif rand > 19 :
			ya += 1
			set_cell(x,ya - 2,get_tileset().find_tile_by_name("up"), true)
			set_cell(x, ya - 1, get_tileset().find_tile_by_name("dirt"))
			set_cell(x - 1, ya - 2, get_tileset().find_tile_by_name("top"))
		
		else :
			set_cell(x,yt,get_tileset().find_tile_by_name("top"))

		y = ya
		yt = ya - 1
		if get_cell(x-2, ya -1) == get_tileset().find_tile_by_name("top") && get_cell(x-1, ya -1) == get_tileset().find_tile_by_name("up"):
			set_cell(x-1, ya -1, get_tileset().find_tile_by_name("top"))
		if get_cell(x, ya -2) == get_tileset().find_tile_by_name("up") && get_cell(x-1, ya -3) == get_tileset().find_tile_by_name("up"):
			set_cell(x -1, ya -2 , get_tileset().find_tile_by_name("dirt"))
		
		
func _test():
	pos = get_global_mouse_pos()
	grid = world_to_map( pos )
	cell = get_cell( grid.x, grid.y )
	print ("pos: ", grid, "sel ", cell)

func _on_player_body_enter( body ):
	get_node("../player").onfloor = true
	pass # replace with function body
