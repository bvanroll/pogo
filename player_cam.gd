extends Camera3D
@onready
var player = $"../player"

const cam_speed = 20.0
const cam_distance = 2.0
const player_height = 2.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y = move_toward(position.y, player.position.y + cam_distance + player_height/2., cam_speed * delta)
	position.z = move_toward(position.z, player.position.z + cam_distance, cam_speed*delta)
	position.x = move_toward(position.x, player.position.x, cam_speed* delta)
	look_at(player.rotation + Vector3(0., player_height, 0.))
	
	pass
