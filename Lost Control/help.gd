extends RichTextLabel

var text_template = "[center]Where is the remote? I have only %s seconds until my favorite TV show starts![/center]"
var win_text = "[center]I found it![/center]"

func _process(_delta):
	if (get_parent().get_parent().is_win):
		bbcode_text = win_text
	else:
		var time = get_parent().get_parent().timer.time_left
		var seconds = int(fposmod(time, 60.0))
		bbcode_text = text_template % [seconds]
