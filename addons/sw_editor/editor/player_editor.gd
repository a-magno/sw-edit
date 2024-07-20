@tool
extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var has_file = SWEdit.get_env_file()
	if not has_file:
		print("Creating .env file...")
		%ConfigEnv.confirmed.connect(_config_env_confirmed)
		%ConfigEnv.show()
	else:
		_show_editor()
	
func _show_editor():
	print("Showing editor...")
	%Editor.show()

func _config_env_confirmed():
	SWEdit.apiKey = %apiKey.text
	SWEdit.gameId = %gameId.text
	SWEdit.save_env_file()
	_show_editor()

func _on_data_retrieved(data):
	%AwaitPanel.hide()
	%PlayerData.text = await JSON.stringify(data, "\t")
	%SaveData.disabled = false
	%SaveJSON.disabled = false

func _on_save_data_pressed():
	var data = JSON.parse_string(%PlayerData.text)
	SWEdit.post_sw_player_data(SWEdit.curr_player_name, data)

func _on_data_requested():
	%AwaitPanel.show()
	%AwaitMsgLabel.text = "[center]Awaiting SilentWolf..."

func _on_save_json_pressed():
	%SaveLocation.show()
	
func _on_save_location_dir_selected(dir):
	var path = "{dir}/{player_name}.json".format({"dir":dir, "player_name":SWEdit.curr_player_name})
	print(path)
	var data = JSON.parse_string(%PlayerData.text)
	var f = FileAccess.open(path, FileAccess.WRITE)
	f.store_string(%PlayerData.text)
	f.close()
	
	
