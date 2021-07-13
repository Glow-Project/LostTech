extends AudioStreamPlayer

var pos

func _ready():
	# don't play it before here in order to avoid sound glitches.
	# previously the AudioStreamPlayer's autoplay option was set and the
	# sound was loud for the first second in game. This is necessary
	# since the loudness is depending on the distance
	play()

func _process(delta):
	#
	# Immersive positional audio feeling
	#
	# Calculate the current distance between player and club. Therefore the 
	# club has a special position node.
	var player = get_parent().get_node_or_null("Player")
	if (is_instance_valid(player)):
		pos = get_parent().get_node("Player").position
	
	# The distance can be calculated via L2-Norm aka euclidean distance aka
	# pythagoras theorem.	
	var distance = sqrt(
		pow(pos.x - $ClubPosition.position.x,2) + 
		pow(pos.y - $ClubPosition.position.y,2)
		)
	
	# transform the distance into a negative volume level
	# *   0 means normal volume
	# * -80 quiet
	volume_db = -min(80, pow(distance/30,2))
	#           ^^   ^   ^            ^
	#           ||   |   |            |- low value = volume fades away quickly 
	#           ||   |   |               with distance
	#           ||   |   |-increase/decrease volume quadratic of the distance
	#           ||   |     which is more natural
	#           ||   |-of highest negative volume level (see inspector)
	#           ||-ensure that negative volume level can't get over the limit 
	#           |  of the player
	#           |-negate level in order to get a proper volume level  
