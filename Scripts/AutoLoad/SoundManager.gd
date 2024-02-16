extends Node

var MusicPlayer : AudioStreamPlayer2D
var CompleteSoundTimer : Timer

var SFXChannels =[]
var SFXChannelAmount = 13

var MusicTweenOut : Tween
var MusicTweenIn : Tween

var MusicToChangeTo = null
var StartPosition = 0

var SFX2DChannel
var SFX2DAudioPath



func _ready():
	print_debug("ready")
	process_mode = Node.PROCESS_MODE_ALWAYS
	MusicPlayer = AudioStreamPlayer2D.new()
	MusicPlayer.set_bus("Music")
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
		instance.set_bus("SFX")
		add_child(instance)
		SFXChannels.append(instance)

	SFX2DChannel = AudioStreamPlayer2D.new()
	SFX2DChannel.set_bus("SFX")
	add_child(SFX2DChannel)

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

func PlaySFX(audioPath, position, forceChannel = -1, startPosition = 0.0):
	var channel = FindOpenChannel()
	if forceChannel != -1:
		channel = SFXChannels[forceChannel]
	if is_instance_valid(channel):
		channel.stream = load(audioPath)
		channel.global_position = position
		channel.play(startPosition)

func StopSFX(channel):
	SFXChannels[channel].stop()

func CheckSFXRunning(channel):
	return SFXChannels[channel].playing

func Play2DSFX(audioPath):
	if SFX2DAudioPath != audioPath:
		SFX2DChannel.stream = load(audioPath)
		SFX2DAudioPath = audioPath
	SFX2DChannel.play()

func FindOpenChannel():
	for x in SFXChannels:
		if x.is_playing() == false:
			return x
	return SFXChannels[0]

func OnMusicFinished():
	CompleteSoundTimer.start()

func OnCompleteSoundTimerTimeout():
	MusicPlayer.play()
