@tool
extends VBoxContainer

signal data_retrieved( data : Dictionary )
signal data_requested

func _on_search_submitted(text):
	data_requested.emit()
	SWEdit.curr_player_name = text
	data_retrieved.emit(await SWEdit.get_sw_player_data(text))
