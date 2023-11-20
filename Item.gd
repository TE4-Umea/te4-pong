extends Control


func _ready():
	set_label_name("awdawdawdawd", "blue")
	set_decsription("hej ¥luck€ ¤death¡ ¥ajnwdkjn€ ¤awdawd¡")

func set_label_name(name, color):
	var label_name = $BackPanel/ItemName
	#Namn kan inte vara över 34 tecken, anars försviner den 
	label_name.append_text("[font_size={20}][color=" + 
	color + "][center][b]" +
	name + "[/b][/center][/color][/font_size]")

func set_decsription(text):
	text = "[font_size={15}] " + text + " [/font_size]"
	var decript = $BackPanel/Decription
	var pros_color = "green"
	var cons_color = "red"
	var text_lengt = len(text)
	var count_pros = text.count("¥", 0, text_lengt )
	var count_cons = text.count("€", 0, text_lengt )	
	var word_index1 = 0
	var word_index2 = 0
	
	for n in range(count_pros):
		word_index1 = text.find("¥", word_index1) + 1
		word_index2 = text.find("€", word_index1)
		var test = text.substr(word_index1, word_index2 - word_index1)
		test = test.to_upper()
		text = text.replacen(test, test)
	
	word_index1 = 0
	word_index2 = 0
	
	for n in range(count_cons):
		word_index1 = text.find("¤", word_index1) + 1
		word_index2 = text.find("¡", word_index1)
		var test = text.substr(word_index1, word_index2 - word_index1)
		test = test.to_upper()
		text = text.replacen(test, test)
	
	text = text.replace("¥", "[color=" + pros_color + "]" )
	text = text.replace("€", "[/color]")
	text = text.replace("¤", "[color=" + cons_color + "]")
	text = text.replace("¡", "[/color]")	
	
	print(text)
	decript.append_text(text)
	
	

