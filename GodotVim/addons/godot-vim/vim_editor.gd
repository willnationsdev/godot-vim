tool
extends PanelContainer

export var path_mode_label: NodePath
export var path_text_edit: NodePath

onready var text_edit := get_node(path_text_edit)
onready var mode_label: Label = get_node(path_mode_label)

var plugin: EditorPlugin = null
var vim: Node = null

class VimOptions:
	var alwaysvim: bool = true

func init(p_plugin) -> void:
	plugin = p_plugin
	vim = plugin.singleton
	vim.connect("mode_updated", self, "_on_vim_mode_updated")

func _on_vim_mode_updated(p_mode: int):
	if mode_label:
		mode_label.text = vim.MODE_TEXT[p_mode]