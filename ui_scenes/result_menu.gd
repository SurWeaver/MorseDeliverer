extends Control



func update_from_gathered_messages(gathered_messages: Array) -> void:
	var gathered_symbols = 0
	var missed_symbols = 0

	var word_count = 0
	var word_spoiled = false

	var wrong_words = 0
	var correct_words = 0

	for code in gathered_messages:
		if code == "":
			continue
		if code == " ":
			if word_spoiled:
				wrong_words += 1
			else:
				correct_words += 1
			word_spoiled = false
			word_count += 1
			continue
		if code.find("x") != -1:
			word_spoiled = true
		var current_gathered_symbols = code.replace("x", "").length()
		gathered_symbols += current_gathered_symbols
		missed_symbols += code.length() - current_gathered_symbols

	word_count += 1
	if word_spoiled:
		wrong_words += 1
	else:
		correct_words += 1

	$"%GatheredWordLabel".text = "%s/%s" % [
		correct_words,
		correct_words + wrong_words
	]
	$"%GatheredSymbolLabel".text = "%s/%s" % [
		gathered_symbols,
		gathered_symbols + missed_symbols
	]
	pass
