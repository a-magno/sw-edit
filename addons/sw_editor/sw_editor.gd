@tool
extends EditorPlugin

const SW_SCRIPT = "res://addons/silent_wolf/SilentWolf.gd"
const AUTOLOAD_SCRIPT = "res://addons/sw_editor/autoload.gd"

const EDITOR = preload("res://addons/sw_editor/editor/main.tscn")
var editor_instance

func _enter_tree():
	#add_autoload_singleton("SilentWolf", SW_SCRIPT)
	add_autoload_singleton("SilentWolf", SW_SCRIPT)
	add_autoload_singleton("SWEdit", AUTOLOAD_SCRIPT)
	editor_instance = EDITOR.instantiate()
	get_editor_interface().get_editor_main_screen().add_child(editor_instance)
	_make_visible(false)
	
func _exit_tree():
	if editor_instance:
		editor_instance.queue_free()
	remove_autoload_singleton("SWEdit")
	remove_autoload_singleton("SilentWolf")

func _has_main_screen():
	return true

func _make_visible(visible):
	if editor_instance:
		editor_instance.visible = visible

func _get_plugin_name():
	return "SW Edit"
