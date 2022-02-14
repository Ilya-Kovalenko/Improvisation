extends Node2D


func _ready():
	Network.connect("timer45", self, "start_timer_45")
	Network.connect("timer80", self, "start_timer_80")
	Network.connect("timer420", self, "start_timer_420")


func start_timer_45():
	$ButtonTimer45.text = "0"
	$Texture45.value = 0
	$Timer45.start(1)


func start_timer_80():
	$ButtonTimer80.text = "0"
	$Texture80.value = 0
	$Timer80.start(1)


func start_timer_420():
	$ButtonTimer420.text = "0"
	$Texture420.value = 0
	$Timer420.start(1)


func _on_ButtonTimer45_pressed():
	start_timer_45()
	Network.send_data("!timer45")


func _on_Timer45_timeout():
	$Texture45.value += 1
	$ButtonTimer45.text = str($Texture45.value)
	if $Texture45.value < 45:
		$Timer45.start(1)


func _on_ButtonTimer80_pressed():
	start_timer_80()
	Network.send_data("!timer80")


func _on_Timer80_timeout():
	$Texture80.value += 1
	$ButtonTimer80.text = str($Texture80.value)
	if $Texture80.value < 80:
		$Timer80.start(1)


func _on_ButtonTimer420_pressed():
	start_timer_420()
	Network.send_data("!timer420")


func _on_Timer420_timeout():
	$Texture420.value += 1
	$ButtonTimer420.text = str($Texture420.value)
	if $Texture420.value < 420:
		$Timer420.start(1)


func _on_Button_pressed():
	Network.send_data("gong")


func _on_Button2_pressed():
	Network.send_data("gudok")


func _on_Button3_pressed():
	Network.send_data("ring")


func _on_Button4_pressed():
	Network.send_data("film")
	

func _on_ButtonRound_pressed():
	$ButtonTimer420.visible = true
	$Label420.visible = true
	$Texture420.visible = true
	$ButtonTimer80.visible = false
	$Label80.visible = false
	$Texture80.visible = false
	$ButtonTimer45.visible = false
	$Label45.visible = false
	$Texture45.visible = false
	
	$ColorRect2.color = "#8c02ff"
	$ColorRect3.color = "#bcbcbc"
	$ColorRect4.color = "#bcbcbc"
	
	$Button3.visible = false
	$Button4.visible = false


func _on_ButtonFilm_pressed():
	$ButtonTimer420.visible = false
	$Label420.visible = false
	$Texture420.visible = false
	$ButtonTimer80.visible = false
	$Label80.visible = false
	$Texture80.visible = false
	$ButtonTimer45.visible = true
	$Label45.visible = true
	$Texture45.visible = true
	
	$ColorRect2.color = "#bcbcbc"
	$ColorRect3.color = "#8c02ff"
	$ColorRect4.color = "#bcbcbc"
	
	$Button3.visible = false
	$Button4.visible = true


func _on_ButtonOfficiant_pressed():
	$ButtonTimer420.visible = false
	$Label420.visible = false
	$Texture420.visible = false
	$ButtonTimer80.visible = true
	$Label80.visible = true
	$Texture80.visible = true
	$ButtonTimer45.visible = false
	$Label45.visible = false
	$Texture45.visible = false
	
	$ColorRect2.color = "#bcbcbc"
	$ColorRect3.color = "#bcbcbc"
	$ColorRect4.color = "#8c02ff"
	
	$Button3.visible = true
	$Button4.visible = false
