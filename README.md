# SW Editor
An addon to be used inside the Godot Engine editor together with the SilentWolf addon.

## Installation
### from Github
1. Download this repo
2. Copy the addons folder to your project.
3. SilentWolf is included due to some small changes made so it can be run inside the editor.
4. Enable the SWEditor plugin.
5. Once enabled, it will ask for your SilentWolf Game ID and API Key. This information is stored locally within your project.
### from AssetLib tab
1. Navigate to the Asset Library tab inside the editor.
2. Search for SWEditor
3. Download and install.
4. Enable the SWEditor plugin.
5. Once enabled, it will ask for your SilentWolf Game ID and API Key. This information is stored locally within your project.

## How to use
Swap to the SWEdit tab above, right next to the AssetLib, search for a player's name and edit their data as much as you want. Your .env file won't be visible inside the engine, but if you look at your project's files on the file explorer, it will be under ``addons/sw-editor``

Also, it is recommended, if you're using Git for version control, to add .env to your gitignore list, if you didn't already.
