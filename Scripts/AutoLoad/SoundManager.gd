extends Node

var MusicPlayer : AudioStreamPlayer2D
var CompleteSoundTimer : Timer

var SFXChannels =[]
var SFXChannelAmount = 10

var MusicTweenOut : Tween
var MusicTweenIn : Tween

var MusicToChangeTo = null
var StartPosition = 0


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

	for x in range(0, SFXChannelAmount):
		var instance = AudioStreamPlayer3D.new()
		add_child(instance)
		SFXChannels.append(instance)


func SwitchToMusic(audioPath, tweenOutLength, tweenInLength, startloc = 0):
	if MusicToChangeTo == audioPath:
		return

	StartPosition = startloc

	if is_instance_valid(MusicTweenIn):
		MusicTweenIn.stop()
		MusicTweenOut.stop()

	MusicTweenOut = create_tween()
	MusicTweenOut.connect("finished", Callable(self, "OnMusicOutTweenFinished"))

	MusicTweenIn = create_tween()
	MusicTweenIn.connect("finished", Callable(self, "OnMusicInTweenFinished"))
	MusicToChangeTo = audioPath
	MusicTweenOut.tween_property(MusicPlayer, "volume_db", -200, tweenOutLength)
	MusicTweenIn.tween_property(MusicPlayer, "volume_db", 0, tweenInLength)
	MusicTweenOut.play()

func OnMusicOutTweenFinished():
	MusicPlayer.stream = load(MusicToChangeTo)
	MusicPlayer.play(StartPosition)
	MusicTweenIn.play()

func OnMusicInTweenFinished():
	pass

func PlaySFX(audioPath, position, forceChannel = -1, startPosition = 0):
	var channel = FindOpenChannel()
	if forceChannel != -1:
		channel = SFXChannels[forceChannel]
	if is_instance_valid(channel):
		channel.stream = load(audioPath)
		channel.global_position = position
		channel.play(startPosition)

func FindOpenChannel():
	for x in SFXChannels:
		if x.is_playing() == false:
			return x
	return SFXChannels[0]

func OnMusicFinished():
	CompleteSoundTimer.start()

func OnCompleteSoundTimerTimeout():
	MusicPlayer.play()
