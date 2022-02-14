extends Node

var username = ""

var main = "res://Main.tscn"
var screen = "res://scenes/Screen.tscn"


var spawn = null
var peer = NetworkedMultiplayerENet.new()

func _ready():
	get_tree().connect("network_peer_connected", self, "_on_network_peer_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_network_peer_disconnected")
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")


func join_server(to_ip, username_chosen):
	
	peer.create_client(to_ip, 4242)
	get_tree().set_network_peer(peer)

	
	username = username_chosen
	
	# If a server is detected call _on_connected_to_server() to load the game

func load_game():
	get_tree().change_scene(screen)
	
	yield(get_tree().create_timer(0.01), "timeout")

func get_IP():
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			return ip

func send_data(data):
	peer.send_bytes(data)

func _on_connected_to_server():
	load_game()

func _on_server_disconnected():
	get_tree().change_scene(main)
	
