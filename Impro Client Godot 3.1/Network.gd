extends Node

var main = "res://Main.tscn"
var screen = "res://scenes/Screen.tscn"

#onready var errorLabel = get_node("/root/Main/Error")
# Our WebSocketClient instance.
onready var _client = WebSocketClient.new()


func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_failed", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")


func join_server(to_ip):
	to_ip = "192.168.0.111:9080" #192.168.0.111:9080
	var err = _client.connect_to_url(to_ip)
	if err != OK:
		print("Unable to connect ", err)
		#errorLabel.text = "Unable to connect " + str(err)
		#set_process(false)
		pass


func send_data(pkt):
	_client.get_peer(1).put_packet(pkt.to_utf8())


func get_IP():
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip


func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	
	_client.disconnect_from_host()

	get_tree().change_scene(main)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	_client.get_peer(1).put_packet("Test packet".to_utf8())
	
	get_tree().change_scene(screen)


#func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
#	print("Got data from server: ", _client.get_peer(1).get_packet().get_string_from_utf8())


func _process(_delta):
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()


func _exit_tree():
	_client.disconnect_from_host()
