extends CanvasLayer


func _ready():
	LevelLoader.bHasWon = true
	SoundManager.MusicToChangeTo = null
