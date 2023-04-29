class_name Morse
extends Node


const MORSE_DICT: Dictionary = {
	"a": ".-",
	"b": "-...",
	"c": "-.-.",
	"d": "-..",
	"e": ".",
	"f": "..-.",
	"g": "--.",
	"h": "....",
	"i": "..",
	"j": ".---",
	"k": "-.-",
	"l": ".-..",
	"m": "--",
	"n": "-.",
	"o": "---",
	"p": ".--.",
	"q": "--.-",
	"r": ".-.",
	"s": "...",
	"t": "-",
	"u": "..-",
	"v": "...-",
	"w": ".--",
	"x": "-..-",
	"y": "-.--",
	"z": "--..",

	"1": ".----",
	"2": "..---",
	"3": "...--",
	"4": "....-",
	"5": ".....",
	"6": "-....",
	"7": "--...",
	"8": "---..",
	"9": "----.",
	"0": "-----",

	"?": "..--..",
	"!": "-.-.--",
	".": ".-.-.-",
	",": "--..--",
	";": "-.-.-.",
	":": "---...",
	"+": ".-.-.",
	"-": "-....-",
	"/": "-..-.",
	"=": "-...-",

	" ": " ",
}


static func get_morse_message_symbols(source_message: String) -> PoolStringArray:
	source_message = source_message.to_lower()

	var encoded_symbols = PoolStringArray()
	for symbol in source_message:
		if MORSE_DICT.has(symbol):
			encoded_symbols.append(MORSE_DICT[symbol])
	return encoded_symbols
