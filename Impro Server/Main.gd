extends Control

func _ready():
	$Menu/LocalIP.text = "Local IP: " + Network.get_IP()
	$Menu/Error.hide()

func _on_Host_pressed():
	
	Network.create_server()
	queue_free()
