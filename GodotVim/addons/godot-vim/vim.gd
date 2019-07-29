tool
extends Node
class_name Vim

signal mode_updated(p_mode)

enum Mode {
	NORMAL,
	VISUAL,
	INSERT
}

const MODE_TEXT = {
	Mode.NORMAL: "NORMAL",
	Mode.VISUAL: "VISUAL",
	Mode.INSERT: "INSERT"
}

class Buffer:
	extends Reference
	var id: int
	var text: String

var mode: int = Mode.NORMAL
var buffers: Array
