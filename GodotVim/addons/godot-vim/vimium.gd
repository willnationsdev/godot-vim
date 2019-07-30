# Vim.gd
# author: willnationsdev
# description: Provides a Vim emulation layer over the Godot editor itself.
#              This is more about providing a keyboard based approach to
#              navigating and interacting with the GUI.
#              
#              For the Vim emulation text editor, see VimEditor (vim_editor.gd).
tool
extends Node

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
	var text: String = ""

var mode: int = Mode.NORMAL
var buffers: Array
var plugin: EditorPlugin = null
var editor: VimEditor = null
var seq := PoolStringArray()

func init(p_plugin: EditorPlugin, p_editor: VimEditor) -> void:
	plugin = p_plugin
	editor = p_editor
	buffers.append(Buffer.new())

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventKey:
		pass
