tool
extends PanelContainer
class_name VimEditor

signal vim_request(p_what, p_ud)

export var _path_mode_label: NodePath
export var _path_text_editor: NodePath
export var _path_hotbar: NodePath
export var _path_cmd_edit: NodePath
export var _path_pos_label: NodePath

onready var text_editor: TextEdit = get_node(_path_text_editor) as TextEdit
onready var hotbar: HBoxContainer = get_node(_path_hotbar) as HBoxContainer
onready var mode_label: Label = get_node(_path_mode_label) as Label
onready var cmd_edit: LineEdit = get_node(_path_cmd_edit) as LineEdit
onready var pos_label: Label = get_node(_path_pos_label) as Label

var plugin: EditorPlugin = null

func init(p_plugin: EditorPlugin) -> void:
	plugin = p_plugin