extends Control


func _ready():
	$LocalIP.text = "Local IP: " + Network.get_IP()
	$Timer.start(1)


func _on_Timer_timeout():
	Network.join_server("0")
	$Timer.start(2)
