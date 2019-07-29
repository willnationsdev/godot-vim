tool
extends EditorPlugin

const VimEditorScn := preload("res://addons/godot-vim/vim_editor.tscn")

var vim_editor: PanelContainer = null
var singleton := Vim.new()

var canvas_item_editor_plugin: EditorPlugin = null
var spatial_editor_plugin: EditorPlugin = null
var script_editor_plugin: EditorPlugin = null
var asset_library_editor_plugin: EditorPlugin = null

var btn_2d: ToolButton = null
var btn_3d: ToolButton = null
var btn_script: ToolButton = null
var btn_assetlib: ToolButton = null
var btn_vim: ToolButton = null

var last_used

var editor_start := true

func _enter_tree():
	_setup_other_plugins()
	add_child(singleton)
	var base = get_editor_interface().get_base_control()
	var edi = get_editor_interface()
	vim_editor = VimEditorScn.instance()
	vim_editor.init(self)
	edi.get_editor_viewport().add_child(vim_editor)
	
	var c = Control.new()
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, c)
	var menu = c.get_parent()
	var main_editor_buttons = menu.get_child(2)
	if main_editor_buttons is HBoxContainer:
		btn_2d = main_editor_buttons.get_child(0)
		btn_3d = main_editor_buttons.get_child(1)
		btn_script = main_editor_buttons.get_child(2)
		btn_assetlib = main_editor_buttons.get_child(3)
	
	for a_btn in main_editor_buttons.get_children():
		if a_btn is BaseButton and a_btn.text == "Vim":
			btn_vim = a_btn
			break
	
	c.free()

func _unhandled_key_input(p_event: InputEventKey) -> void:
	if p_event is InputEventWithModifiers:
		if p_event.alt and not (p_event.shift or p_event.meta):
			if p_event.scancode == KEY_SPACE:
				btn_vim.emit_signal("pressed")
			if p_event.scancode == KEY_A:
				btn_2d.emit_signal("pressed")
			if p_event.scancode == KEY_S:
				btn_3d.emit_signal("pressed")
			if p_event.scancode == KEY_D:
				btn_script.emit_signal("pressed")
			if p_event.scancode == KEY_F:
				btn_assetlib.emit_signal("pressed")
		

func _exit_tree():
	if vim_editor:
		vim_editor.free()

func make_visible(p_visible):
	vim_editor.visible = p_visible

func has_main_screen() -> bool:
	return true

func get_plugin_name() -> String:
	return "Vim"

func _setup_other_plugins():
	var count = 0
	for a_child in get_parent().get_children():
		match a_child.get_class():
			"CanvasItemEditorPlugin":
				canvas_item_editor_plugin = a_child
				count += 1
			"SpatialEditorPlugin":
				spatial_editor_plugin = a_child
				count += 1
			"ScriptEditorPlugin":
				script_editor_plugin = a_child
				count += 1
			"AssetLibraryEditorPlugin":
				asset_library_editor_plugin = a_child
				count += 1
		if count == 4:
			break
