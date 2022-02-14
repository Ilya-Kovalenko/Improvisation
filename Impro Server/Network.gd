extends Node

var username = ""

var main = "res://Main.tscn"
var screen = "res://scenes/Screen.tscn"
var vova_id = 0

# The port we will listen to.
const PORT = 9080
# Our WebSocketServer instance.
var _server = WebSocketServer.new()

func _ready():
	# Connect base signals to get notified of new client connections,
	# disconnections, and disconnect requests.
	_server.connect("client_connected", self, "_connected")
	_server.connect("client_disconnected", self, "_disconnected")
	_server.connect("client_close_request", self, "_close_request")
	# This signal is emitted when not using the Multiplayer API every time a
	# full packet is received.
	# Alternatively, you could check get_peer(PEER_ID).get_available_packets()
	# in a loop for each connected peer.
	_server.connect("data_received", self, "_on_data")
	# Start listening on the given port.
	

func create_server():
	var err = _server.listen(PORT)
	if err != OK:
		print("Unable to start server")
		set_process(false)
		
	#get_tree().change_scene(screen)


func get_IP():
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip


func _connected(id, proto):
	# This is called when a new peer connects, "id" will be the assigned peer id,
	# "proto" will be the selected WebSocket sub-protocol (which is optional)
	print("Client %d connected with protocol: %s" % [id, proto])


func _close_request(id, code, reason):
	# This is called when a client notifies that it wishes to close the connection,
	# providing a reason string and close code.
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])


func _disconnected(id, was_clean = false):
	# This is called when a client disconnects, "id" will be the one of the
	# disconnecting client, "was_clean" will tell you if the disconnection
	# was correctly notified by the remote peer before closing the socket.
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])


func _on_data(id):
	# Print the received packet, you MUST always use get_peer(id).get_packet to receive data,
	# and not get_packet directly when not using the MultiplayerAPI.
	var pkt = _server.get_peer(id).get_packet()
	var data = pkt.get_string_from_utf8()
	print("Got data from client %d: %s" % [id, data])
	if data == "left":
		Screen.left_point()
	elif data == "right":
		Screen.right_point()
	elif data == "gong":
		Screen.sound_gong()
	elif data == "film":
		Screen.sound_film()
	elif data == "ring":
		Screen.sound_ring()
	elif data == "gudok":
		Screen.sound_gudok()
	elif data == "Vova connected":
		get_node("/root/Screen/Label").text = str(id)
		vova_id = id
	elif data == "!timer45":
		get_node("/root/Screen/ButtonTimer45").text = "0"
		get_node("/root/Screen/Texture45").value = 0
		get_node("/root/Screen/Timer45").start(1)
	elif data == "!timer80":
		get_node("/root/Screen/ButtonTimer80").text = "0"
		get_node("/root/Screen/Texture80").value = 0
		get_node("/root/Screen/Timer80").start(1)
	elif data == "!timer420":
		get_node("/root/Screen/ButtonTimer420").text = "0"
		get_node("/root/Screen/Texture420").value = 0
		get_node("/root/Screen/Timer420").start(1)


func send_data(pkt):
	if vova_id != 0:
		_server.get_peer(vova_id).put_packet(pkt.to_utf8())

func _process(_delta):
	# Call this in _process or _physics_process.
	# Data transfer, and signals emission will only happen when calling this function.
	
	_server.poll()


func _exit_tree():
	_server.stop()
