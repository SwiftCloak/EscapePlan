extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	set_text(str(variable.winner))
	if(variable.winner == 0):
		set_text("PRISONER WIN")
	else:
		set_text("WARDEN WIN")
	
	
