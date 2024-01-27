extends RichTextLabel


var time = 0
var text_template = "[center]Where is my remote? I have %s seconds until my favorite TV show starts![/center]"


func _ready():
	time = 38
	set_process(true)


func _process(delta):
	time -= delta
	
	var seconds = int(fposmod(time, 60.0))

	text = text_template % [seconds]
