extends Node

var MusicPlayer : AudioStreamPlayer2D
var CompleteSoundTimer : Timer


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	MusicPlayer = AudioStreamPlayer2D.new()
	add_child(MusicPlayer)
	MusicPlayer.stream = load("res://Audio/Brandon_x4_-_Brackey_Jam_-_Ambient_Background_Music_-_Optimized.mp3")
	MusicPlayer.play()
	MusicPlayer.connect("finished", Callable(self, "OnMusicFinished"))

	CompleteSoundTimer = Timer.new()
	CompleteSoundTimer.wait_time = 20
	CompleteSoundTimer.one_shot = true
	add_child(CompleteSoundTimer)
	CompleteSoundTimer.connect("timeout", Callable(self, "OnCompleteSoundTimerTimeout"))



func OnMusicFinished():
	CompleteSoundTimer.start()

func OnCompleteSoundTimerTimeout():
	MusicPlayer.play()
