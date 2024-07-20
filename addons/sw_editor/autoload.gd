@tool
extends Node

var stored_credentials : Array[Dictionary] = []

const SILENT_WOLF = preload("res://addons/silent_wolf/SilentWolf.gd")
var silent_wolf
var curr_player_name

const ENV_PATH = "res://addons/sw_editor/apiKey.env"
var apiKey
var gameId

func _ready():
	load_sw_keys()
	if Engine.is_editor_hint():
		silent_wolf = $"/root".get_node("SilentWolf")
	else:
		silent_wolf = SilentWolf
	configure_sw()

func get_sw_player_data(player_name : String):
	assert(player_name.length() > 0, "Cannot search for an empty name.")
	var sw_result = await silent_wolf.Players.get_player_data(player_name).sw_get_player_data_complete
	if sw_result:
		return sw_result.player_data
	return null

func post_sw_player_data(player_name : String, data : Dictionary):
	assert(player_name.length() > 0, "Cannot find player with an empty name.")
	silent_wolf.Players.save_player_data(player_name, data)
	
func configure_sw():
	silent_wolf.configure({
			"api_key":apiKey,
			"game_id":gameId,
			"log_level": 1
		})
	print("SilentWolf configured.")

func load_sw_keys():
	print("Getting API key and ID...")
	var f=get_env_file()
	var env = f.get_line()
	env = env.split("=")
	
	gameId = env[0]
	apiKey = env[1]
	
	print("API key and ID set.")
	f.close()

func get_env_file():
	var f = FileAccess.open(ENV_PATH,FileAccess.READ)
	return f

func save_env_file():
	var f = FileAccess.open(ENV_PATH, FileAccess.WRITE)
	f.store_line(
		"{id}={api}".format({
				"id":gameId,
				"api":apiKey
			}))
	f.close()
