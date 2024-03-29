extends TileMap

enum CellType { EMPTY = -1, ACTOR, OBSTACLE, OBJECT}
func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)
		


func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)


func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		CellType.EMPTY:
			return update_pawn_position(pawn, cell_start, cell_target)
		CellType.OBJECT:
			var pawn_name = get_cell_pawn(cell_start).name
			if(pawn_name == "Actor"):
				var object_pawn = get_cell_pawn(cell_target)
				object_pawn.queue_free()
				print("PRISONER WIN")
				variable.gameState = 2
				return update_pawn_position(pawn, cell_start, cell_target)
			else:
				print("YOU CAN'T GO HERE")
				variable.turn -= 1
		CellType.ACTOR:
			var pawn_name = get_cell_pawn(cell_target).name
			print("Cell %s contains %s" % [cell_target, pawn_name])
			print("PRISONER LOSE, WARDEN WIN")
			variable.winner = 1
			variable.gameState = 2
			


func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, CellType.EMPTY)
	return map_to_world(cell_target) + cell_size / 2
