extends Control


var counterLeft = 0
var counterRight = 0
var package = ""
var ide = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$LabelIp.text = "IP: " + Network.get_IP()


func sound_gong():
	if !$SoundGong.playing:
		$SoundGong.play()


func sound_film():
	if !$SoundFilm.playing:
		$SoundFilm.play()


func sound_ring():
	if !$SoundRing.playing:
		$SoundRing.play()
	elif !$SoundRing2.playing:
		$SoundRing2.play()
	elif !$SoundRing3.playing:
		$SoundRing3.play()
	elif !$SoundRing4.playing:
		$SoundRing4.play()
	elif !$SoundRing5.playing:
		$SoundRing5.play()
	elif !$SoundRing6.playing:
		$SoundRing6.play()


func sound_gudok():
	if !$SoundGudok.playing:
		$SoundGudok.play()


func left_point():
	counterLeft += 1
	$LabelLeft.text = str(counterLeft)
	if !$Sound.playing:
		$Sound.play()
	elif !$Sound2.playing:
		$Sound2.play()
	elif !$Sound3.playing:
		$Sound3.play()
	elif !$Sound4.playing:
		$Sound4.play()
	elif !$Sound5.playing:
		$Sound5.play()
	elif !$Sound6.playing:
		$Sound6.play()
	elif !$Sound7.playing:
		$Sound7.play()
	elif !$Sound8.playing:
		$Sound8.play()
	elif !$Sound9.playing:
		$Sound9.play()
	elif !$Sound10.playing:
		$Sound10.play()


func right_point():
	counterRight += 1
	$LabelRight.text = str(counterRight)
	if !$Sound.playing:
		$Sound.play()
	elif !$Sound2.playing:
		$Sound2.play()
	elif !$Sound3.playing:
		$Sound3.play()
	elif !$Sound4.playing:
		$Sound4.play()
	elif !$Sound5.playing:
		$Sound5.play()
	elif !$Sound6.playing:
		$Sound6.play()
	elif !$Sound7.playing:
		$Sound7.play()
	elif !$Sound8.playing:
		$Sound8.play()
	elif !$Sound9.playing:
		$Sound9.play()
	elif !$Sound10.playing:
		$Sound10.play()


func _on_Button_pressed():
	$LabelRight.text = "0"
	$LabelLeft.text = "0"
	counterRight = 0
	counterLeft = 0


func _on_ButtonSend_pressed():
	package = $TextEdit.text
	if package == "":
		package = " "
		
	if $Label.text != "":
		Network.send_data(package)
	else:
		$TextEdit.text = "Нет подключения"


func _on_ButtonTimer45_pressed():
	Network.send_data("!timer45")
	start_timer_45()


func _on_ButtonTimer80_pressed():
	Network.send_data("!timer80")
	start_timer_80()


func _on_ButtonTimer420_pressed():
	Network.send_data("!timer420")
	start_timer_420()


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


func _on_Timer45_timeout():
	$Texture45.value += 1
	$ButtonTimer45.text = str($Texture45.value)
	if $Texture45.value < 45:
		$Timer45.start(1)


func _on_Timer80_timeout():
	$Texture80.value += 1
	$ButtonTimer80.text = str($Texture80.value)
	if $Texture80.value < 80:
		$Timer80.start(1)


func _on_Timer420_timeout():
	$Texture420.value += 1
	$ButtonTimer420.text = str($Texture420.value)
	if $Texture420.value < 420:
		$Timer420.start(1)
