extends MarginContainer

@onready var launchButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/LaunchButton

@onready var welcomeText: = $MarginContainer/VBoxContainer/HBoxContainer/DescriptionContainer/VBoxContainer/ScrollContainer/Description
@onready var descriptionLabel: = $MarginContainer/VBoxContainer/HBoxContainer/DescriptionContainer/VBoxContainer/HBoxContainer/ScrollContainer2/Tooltip

@onready var advancedCheckButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/AdvancedCheckButton

@onready var msLogo: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/TextureRect
@onready var profileLabel: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/ProfileLabel
@onready var profileDropdown: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/OptionButton
@onready var skinLabel: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SkinLabel
@onready var skinDropdown: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SkinDropdown
@onready var brighterIntLabel: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/BrighterIntLabel
@onready var brighterIntDropdown: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/BrighterIntDropdown
@onready var ultrawideLabel: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/UltrawideLabel
@onready var ultrawideDropdown: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/UltrawideDropdown
@onready var enbButton: = $MarginContainer/VBoxContainer/HBoxContainer2/EnbButton
@onready var mcmButton: = $MarginContainer/VBoxContainer/HBoxContainer2/McmButton
@onready var versionLabel: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/versionLabel
@onready var skimpyMaleBox: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SkimpyMaleCheckbox
@onready var skimpyFemaleBox: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/SkimpyFemaleCheckbox
@onready var spacer: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Spacer
@onready var launchWJButton: = $MarginContainer/VBoxContainer/HBoxContainer2/LaunchWJButton
@onready var bugReportButton: = $MarginContainer/VBoxContainer/HBoxContainer2/BugReportButton
@onready var instructions: = $MarginContainer/VBoxContainer/HBoxContainer/DescriptionContainer/VBoxContainer/ScrollContainer/Description
@onready var hSeparator1: = $MarginContainer/VBoxContainer/HBoxContainer/DescriptionContainer/VBoxContainer/HSeparator
@onready var installLocationButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/InstallLocationButton
@onready var fileDialog: = $FileDialog
@onready var installLocationButton2: = $MarginContainer/VBoxContainer/HBoxContainer3/InstallLocationButton2
@onready var skinPreview: = $MarginContainer/VBoxContainer/HBoxContainer/DescriptionContainer/VBoxContainer/SkinPreview

@onready var folderButtonsLabel: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/FolderButtonsLabel
@onready var regularSavesButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/RegularSavesButton
@onready var creatureSavesButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CreatureSavesButton
@onready var stockGameButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/StockGameFolderButton
@onready var racemenuFolderButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/RaceMenuPresetsFolderButton
@onready var bodyslideFolderButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/BodyslidePresetsFolderButton
@onready var crashlogFolderButton: = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/CrashLogsFolderButton
@onready var browseFoldersButton: = $MarginContainer/VBoxContainer/HBoxContainer2/BrowseFoldersButton

@onready var mo2Button: = $MarginContainer/VBoxContainer/HBoxContainer3/MO2Button
@onready var bethIniButton: = $MarginContainer/VBoxContainer/HBoxContainer3/BethINIButton

var configFile = ConfigFile.new()
var configFilePath = "res://launcher.cfg"
var dragpoint = null

var wabbajackPath = ""
var basePath = ""
var mo2Path = ""
var bethIniPath = ""
var enbOrgPath = ""
var regularProfileLoadOrderPath = ""
var creatureProfileLoadOrderPath = ""
var regularProfileSavesPath = ""
var creatureProfileSavesPath = ""

var listInstalled = false
var advancedMode = false
var skimpyMale = false
var skimpyFemale = false

var folderMode = false

func _ready():
	RenderingServer.set_default_clear_color(Color.hex(0x212529ff))
	
	if configFile.load(configFilePath) == OK:
		print("config file loaded")
		profileDropdown.select(configFile.get_value("General", "selected_profile", 0))
		skinDropdown.select(configFile.get_value("General", "selected_skin", 0))
		brighterIntDropdown.select(configFile.get_value("General", "selected_brighter_interiors", 0))
		ultrawideDropdown.select(configFile.get_value("General", "selected_ultrawide", 0))		
		skimpyFemaleBox.set_pressed_no_signal(configFile.get_value("General", "female_skimpy", false))
		skimpyMaleBox.set_pressed_no_signal(configFile.get_value("General", "male_skimpy", false))
		
		skimpyFemale = configFile.get_value("General", "female_skimpy", false)
		skimpyMale = configFile.get_value("General", "male_skimpy", false)
		
		wabbajackPath = OS.get_executable_path().get_base_dir().path_join("Wabbajack.exe")
		basePath = configFile.get_value("Paths", "basePath", OS.get_executable_path().get_base_dir().path_join("/Masterstroke Install Folder/"))
		mo2Path = configFile.get_value("Paths", "mo2Path", OS.get_executable_path().get_base_dir().path_join("/Masterstroke Install Folder/ModOrganizer.exe"))
		bethIniPath = configFile.get_value("Paths", "bethIniPath", OS.get_executable_path().get_base_dir().path_join("/Masterstroke Install Folder/tools/BethINI/BethINI.exe"))
		enbOrgPath = configFile.get_value("Paths", "enbOrgPath", OS.get_executable_path().get_base_dir().path_join("/Masterstroke Install Folder/tools/BethINI/BethINI.exe"))
		regularProfileLoadOrderPath = configFile.get_value("Paths", "regularProfilePath", OS.get_executable_path().get_base_dir().path_join("/Masterstroke Install Folder/profiles/Masterstroke/modlist.txt"))
		creatureProfileLoadOrderPath = configFile.get_value("Paths", "creatureProfilePath", OS.get_executable_path().get_base_dir().path_join("/Masterstroke Install Folder/profiles/Masterstroke (Creature Profile)/modlist.txt"))
		regularProfileSavesPath = configFile.get_value("Paths", "regularProfileSavePath", OS.get_executable_path().get_base_dir().path_join("/Masterstroke Install Folder/profiles/Masterstroke/saves"))
	
	if FileAccess.file_exists(mo2Path):
		listInstalled = true
		print("list install found")
	else:
		listInstalled = false
		print("list install not found")
		print(mo2Path)
		
	skinPreview.visible = false
	folderButtonsLabel.visible = false
	regularSavesButton.visible = false
	creatureSavesButton.visible = false
	stockGameButton.visible = false
	racemenuFolderButton.visible = false
	bodyslideFolderButton.visible = false
	crashlogFolderButton.visible = false
	
	if listInstalled:
		msLogo.size_flags_stretch_ratio = 5
		spacer.visible = false
		launchButton.text = "Launch Masterstroke"
		profileDropdown.visible = true
		profileLabel.visible = true
		advancedCheckButton.visible = true
		skinLabel.visible = true
		skinDropdown.visible = true
		brighterIntLabel.visible = true
		brighterIntDropdown.visible = true
		ultrawideLabel.visible = true
		ultrawideDropdown.visible = true
		enbButton.visible = true
		mcmButton.visible = true
		versionLabel.visible = true
		skimpyMaleBox.visible = true
		skimpyFemaleBox.visible = true
		launchWJButton.visible = true
		bugReportButton.visible = true
		installLocationButton.visible = false
		browseFoldersButton.visible = true
		instructions.text = "Welcome to the Masterstroke launcher!\n\nYou can configure the modlist to your liking using the settings on the left. When you're ready, press \"Launch Masterstroke\" to begin playing."
	else:
		msLogo.size_flags_stretch_ratio = 1
		launchButton.text = "Launch Wabbajack"
		launchButton.size_flags_stretch_ratio = 1
		spacer.visible = true
		spacer.size_flags_stretch_ratio = 3
		profileDropdown.visible = false
		profileLabel.visible = false
		advancedCheckButton.visible = false
		skinLabel.visible = false
		skinDropdown.visible = false
		brighterIntLabel.visible = false
		brighterIntDropdown.visible = false
		ultrawideLabel.visible = false
		ultrawideDropdown.visible = false
		enbButton.visible = false
		mcmButton.visible = false
		versionLabel.visible = false
		skimpyMaleBox.visible = false
		skimpyFemaleBox.visible = false
		launchWJButton.visible = false
		bugReportButton.visible = false
		installLocationButton.visible = true
		browseFoldersButton.visible = false
		instructions.text = "Welcome to the Masterstroke launcher!\n\nIt looks like you haven't installed Masterstroke yet. You can launch Wabbajack to install the modlist from this program by clicking the \"Launch Wabbajack\" button. Refer to the Masterstroke documentation for information on how to properly install Masterstroke."
	
	mo2Button.visible = advancedMode
	bethIniButton.visible = advancedMode
	installLocationButton2.visible = advancedMode
	
	versionLabel.text = "Version: " + get_version(regularProfileLoadOrderPath)

func _on_launch_button_pressed():
	if profileDropdown.get_selected_id() == 0 and listInstalled:
		var _pid2 = OS.create_process(mo2Path, ["-p", "Masterstroke", "SKSE"])
	elif profileDropdown.get_selected_id() == 1 and listInstalled:
		var _pid = OS.create_process(mo2Path, ["-p", "Masterstroke (Creature Profile)", "SKSE"])
	elif listInstalled == false:
		var _wjid = OS.create_process(wabbajackPath, [], false)
		OS.shell_open("https://www.fgsmodlists.com/docs/masterstroke/installation-guide/")
		get_tree().quit()
	else:
		pass
	
func _on_option_button_item_selected(index):
	if index == 0:
		descriptionLabel.text = "The regular profile for Masterstroke."
		configFile.set_value("General", "selected_profile", index)
		configFile.save(configFilePath)
	elif index == 1:
		descriptionLabel.text = "The creature profile for Masterstroke."
		configFile.set_value("General", "selected_profile", index)
		configFile.save(configFilePath)
	else:
		pass


func _on_advanced_check_button_toggled(_button_pressed):
	advancedMode = not advancedMode
	mo2Button.visible = advancedMode
	bethIniButton.visible = advancedMode
	installLocationButton2.visible = advancedMode

func _on_mo_2_button_mouse_entered():
	descriptionLabel.text = "Launches Mod Organizer 2. You really shouldn't need to use this, ever."

func _on_beth_ini_button_mouse_entered():
	descriptionLabel.text = "Launches BethINI. BethINI is a program that allows you to configure Skyrim's INI settings, such as graphics quality presets.\n\nMake sure to only launch BethINI if Mod Organizer 2 is closed."

func _on_docs_button_mouse_entered():
	descriptionLabel.text = "Open the documentation for Masterstroke on the FG's Modlists website."
	
func _on_bug_report_button_mouse_entered():
	descriptionLabel.text = "Open the bug report form for Masterstroke."

func _on_discord_button_mouse_entered():
	descriptionLabel.text = "Open the FG's Modlists Discord server. You can get support directly from the FG's Modlists team here."
	
func _on_patreon_button_mouse_entered():
	descriptionLabel.text = "Open the FG's Modlists Patreon webpage."
	
func _on_ko_fi_button_mouse_entered():
	descriptionLabel.text = "Open the FG's Modlists Ko-Fi webpage."

func _on_launch_button_mouse_entered():
	if not listInstalled:
		descriptionLabel.text = "Close the launcher and open Wabbajack, which you'll use to install the modlist. Also opens the Installation Guide for Masterstroke."
	else:
		descriptionLabel.text = "Launch Masterstroke with the chosen profile."

func _on_mo_2_button_pressed():
	OS.create_process(mo2Path, [], false)

func _on_beth_ini_button_pressed():
	OS.create_process(bethIniPath, [], false)

func _on_docs_button_pressed():
	OS.shell_open("https://www.fgsmodlists.com/docs/masterstroke/")

func _on_bug_report_button_pressed():
	OS.shell_open("https://www.fgsmodlists.com/docs/masterstroke/bug-report/")

func _on_discord_button_pressed():
	OS.shell_open("https://discord.gg/WKZgPuxvHS")

func _on_patreon_button_pressed():
	OS.shell_open("https://www.patreon.com/LivingSkyrim")
	
func _on_ko_fi_button_pressed():
	OS.shell_open("https://ko-fi.com/forgottenglory")

func _on_close_button_pressed():
	get_tree().quit()

func _on_skin_dropdown_item_selected(index):
	var profilePath = get_profile_path()
		
	match index:
		0: #Fair Skin, default
			find_and_replace(profilePath, "+Leyenda Skin", "-Leyenda Skin")
			find_and_replace(profilePath, "+Leyenda Skin (Muscular)", "-Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "+Demoniac_Texture", "-Demoniac_Texture")
			find_and_replace(profilePath, "+Diamond Skin - CBBE and UNP Female Textures", "-Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "+The Pure - CBBE", "-The Pure - CBBE")
			find_and_replace(profilePath, "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "-Fair Skin Complexion", "+Fair Skin Complexion")
			find_and_replace(profilePath, "+Binibini Skin for CBBE 3BA COCO", "-Binibini Skin for CBBE 3BA COCO")
			skinPreview.texture = load("res://Skins/FairSkin.tres")
			descriptionLabel.text = "Enabled Fair Skin Complexion."
		1: #Leyenda
			find_and_replace(profilePath, "-Leyenda Skin", "+Leyenda Skin")
			find_and_replace(profilePath, "+Leyenda Skin (Muscular)", "-Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "+Demoniac_Texture", "-Demoniac_Texture")
			find_and_replace(profilePath, "+Diamond Skin - CBBE and UNP Female Textures", "-Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "+The Pure - CBBE", "-The Pure - CBBE")
			find_and_replace(profilePath, "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "+Fair Skin Complexion", "-Fair Skin Complexion")
			find_and_replace(profilePath, "+Binibini Skin for CBBE 3BA COCO", "-Binibini Skin for CBBE 3BA COCO")
			skinPreview.texture = load("res://Skins/Leyenda.png")
			descriptionLabel.text = "Enabled Leyenda Skin."
		2: #Leyenda Muscular
			find_and_replace(profilePath, "+Leyenda Skin", "-Leyenda Skin")
			find_and_replace(profilePath, "-Leyenda Skin (Muscular)", "+Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "+Demoniac_Texture", "-Demoniac_Texture")
			find_and_replace(profilePath, "+Diamond Skin - CBBE and UNP Female Textures", "-Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "+The Pure - CBBE", "-The Pure - CBBE")
			find_and_replace(profilePath, "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "+Fair Skin Complexion", "-Fair Skin Complexion")
			find_and_replace(profilePath, "+Binibini Skin for CBBE 3BA COCO", "-Binibini Skin for CBBE 3BA COCO")
			skinPreview.texture = load("res://Skins/LeyendaMusc.tres")
			descriptionLabel.text = "Enabled Leyenda Skin (Muscular)."
		3: #Demoniac
			find_and_replace(profilePath, "+Leyenda Skin", "-Leyenda Skin")
			find_and_replace(profilePath, "+Leyenda Skin (Muscular)", "-Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "-Demoniac_Texture", "+Demoniac_Texture")
			find_and_replace(profilePath, "+Diamond Skin - CBBE and UNP Female Textures", "-Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "+The Pure - CBBE", "-The Pure - CBBE")
			find_and_replace(profilePath, "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "+Fair Skin Complexion", "-Fair Skin Complexion")
			find_and_replace(profilePath, "+Binibini Skin for CBBE 3BA COCO", "-Binibini Skin for CBBE 3BA COCO")
			skinPreview.texture = load("res://Skins/Demoniac.tres")
			descriptionLabel.text = "Enabled Demoniac Skin."
		4: #Diamond
			find_and_replace(profilePath, "+Leyenda Skin", "-Leyenda Skin")
			find_and_replace(profilePath, "+Leyenda Skin (Muscular)", "-Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "+Demoniac_Texture", "-Demoniac_Texture")
			find_and_replace(profilePath, "-Diamond Skin - CBBE and UNP Female Textures", "+Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "+The Pure - CBBE", "-The Pure - CBBE")
			find_and_replace(profilePath, "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "+Fair Skin Complexion", "-Fair Skin Complexion")
			find_and_replace(profilePath, "+Binibini Skin for CBBE 3BA COCO", "-Binibini Skin for CBBE 3BA COCO")
			skinPreview.texture = load("res://Skins/Diamond.tres")
			descriptionLabel.text = "Enabled Diamond Skin."
		5: #The Pure
			find_and_replace(profilePath, "+Leyenda Skin", "-Leyenda Skin")
			find_and_replace(profilePath, "+Leyenda Skin (Muscular)", "-Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "+Demoniac_Texture", "-Demoniac_Texture")
			find_and_replace(profilePath, "+Diamond Skin - CBBE and UNP Female Textures", "-Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "-The Pure - CBBE", "+The Pure - CBBE")
			find_and_replace(profilePath, "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "+Fair Skin Complexion", "-Fair Skin Complexion")
			find_and_replace(profilePath, "+Binibini Skin for CBBE 3BA COCO", "-Binibini Skin for CBBE 3BA COCO")
			skinPreview.texture = load("res://Skins/ThePure.tres")
			descriptionLabel.text = "Enabled The Pure Skin."
		6: #Pride Of Valhalla
			find_and_replace(profilePath, "+Leyenda Skin", "-Leyenda Skin")
			find_and_replace(profilePath, "+Leyenda Skin (Muscular)", "-Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "+Demoniac_Texture", "-Demoniac_Texture")
			find_and_replace(profilePath, "+Diamond Skin - CBBE and UNP Female Textures", "-Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "+The Pure - CBBE", "-The Pure - CBBE")
			find_and_replace(profilePath, "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "+Binibini Skin for CBBE 3BA COCO", "-Binibini Skin for CBBE 3BA COCO")
			find_and_replace(profilePath, "+Fair Skin Complexion", "-Fair Skin Complexion")
			skinPreview.texture = load("res://Skins/PrideOfValhalla.tres")
			descriptionLabel.text = "Enabled Pride of Valhalla Skin."
		7: #Binibini
			find_and_replace(profilePath, "+Leyenda Skin", "-Leyenda Skin")
			find_and_replace(profilePath, "+Leyenda Skin (Muscular)", "-Leyenda Skin (Muscular)")
			find_and_replace(profilePath, "+Demoniac_Texture", "-Demoniac_Texture")
			find_and_replace(profilePath, "+Diamond Skin - CBBE and UNP Female Textures", "-Diamond Skin - CBBE and UNP Female Textures")
			find_and_replace(profilePath, "+The Pure - CBBE", "-The Pure - CBBE")
			find_and_replace(profilePath, "+Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE", "-Pride of Valhalla - Super HD Skin Set for UNP-UNPB-7B-CBBE")
			find_and_replace(profilePath, "+Fair Skin Complexion", "-Fair Skin Complexion")
			find_and_replace(profilePath, "-Binibini Skin for CBBE 3BA COCO", "+Binibini Skin for CBBE 3BA COCO")
			skinPreview.texture = null
			descriptionLabel.text = "Enabled Binibini skin."
			
	configFile.set_value("General", "selected_skin", index)
	configFile.save(configFilePath)

func _on_brighter_int_dropdown_item_selected(index):
	var profilePath = get_profile_path()
	
	if index == 0:
		find_and_replace(profilePath, "+Masterstroke Brighter Interiors", "-Masterstroke Brighter Interiors")
		descriptionLabel.text = "Disabled Brighter Interiors."
	elif index == 1:
		find_and_replace(profilePath, "-Masterstroke Brighter Interiors", "+Masterstroke Brighter Interiors")
		descriptionLabel.text = "Enabled Brighter Interiors."
		
	configFile.set_value("General", "selected_brighter_interiors", index)
	configFile.save(configFilePath)
		
func _on_ultrawide_dropdown_item_selected(index):
	var profilePath = get_profile_path()
	
	match index:
		0: # 16x9
			find_and_replace(profilePath, "+NORDIC UI - Ultrawide Fixes and Patches", "-NORDIC UI - Ultrawide Fixes and Patches")
			find_and_replace(profilePath, "+Nordic UI 32 by 9", "-Nordic UI 32 by 9")
			find_and_replace(profilePath, "+The Elder Scrolls Legends - Loading Screens 21x9", "-The Elder Scrolls Legends - Loading Screens 21x9")
			find_and_replace(profilePath, "+Nordic UI 21 by 9", "-Nordic UI 21 by 9")
			find_and_replace(profilePath, "+NORDIC UI - Ultrawide Fixes and Patches (32x9)", "-NORDIC UI - Ultrawide Fixes and Patches (32x9)")
			descriptionLabel.text = "Disabled Ultrawide add-ons."
		1: # 21x9
			find_and_replace(profilePath, "-NORDIC UI - Ultrawide Fixes and Patches", "+NORDIC UI - Ultrawide Fixes and Patches")
			find_and_replace(profilePath, "+Nordic UI 32 by 9", "-Nordic UI 32 by 9")
			find_and_replace(profilePath, "-The Elder Scrolls Legends - Loading Screens 21x9", "+The Elder Scrolls Legends - Loading Screens 21x9")
			find_and_replace(profilePath, "-Nordic UI 21 by 9", "+Nordic UI 21 by 9")
			find_and_replace(profilePath, "+NORDIC UI - Ultrawide Fixes and Patches (32x9)", "-NORDIC UI - Ultrawide Fixes and Patches (32x9)")
			descriptionLabel.text = "Enabled 21x9 Ultrawide add-ons."
		2: # 32x9
			find_and_replace(profilePath, "-NORDIC UI - Ultrawide Fixes and Patches", "+NORDIC UI - Ultrawide Fixes and Patches")
			find_and_replace(profilePath, "-Nordic UI 32 by 9", "+Nordic UI 32 by 9")
			find_and_replace(profilePath, "-The Elder Scrolls Legends - Loading Screens 21x9", "+The Elder Scrolls Legends - Loading Screens 21x9")
			find_and_replace(profilePath, "+Nordic UI 21 by 9", "-Nordic UI 21 by 9")
			find_and_replace(profilePath, "-NORDIC UI - Ultrawide Fixes and Patches (32x9)", "+NORDIC UI - Ultrawide Fixes and Patches (32x9)")
			descriptionLabel.text = "Enabled 32x9 Ultrawide add-ons."
			
	configFile.set_value("General", "selected_ultrawide", index)
	configFile.save(configFilePath)
			
func _on_enb_button_mouse_entered():
	descriptionLabel.text = "Launch ENB Organizer, which you can use to select a different ENB preset for the modlist."

func _on_enb_button_pressed():
	var _enbID = OS.create_process(mo2Path, ["ENB Organizer"])

func find_and_replace(file_path, line_to_find, replace_with):
	var file = FileAccess.open(file_path, FileAccess.READ_WRITE)
	
	var found_line = false
	var lines = []
	
	while not file.eof_reached():
		var line = file.get_line()
		if line == line_to_find:
			found_line = true
			lines.append(replace_with)
		else:
			lines.append(line)
	
	file.close()
	
	file = FileAccess.open(file_path, FileAccess.WRITE)
	
	for i in lines.size():
		file.store_string(lines.pop_front() + "\n")
	
	if found_line == true:
		print("Replaced string " + line_to_find + " with " + replace_with + " successfully")
	
	file.close()
	
func get_profile_path():
	if profileDropdown.get_selected_id() == 0:
		return regularProfileLoadOrderPath
	elif profileDropdown.get_selected_id() == 1:
		return creatureProfileLoadOrderPath

func _on_brighter_int_dropdown_mouse_entered():
	descriptionLabel.text = "This option allows you to enable or disable the optional Brighter Interiors add-on. Select Yes if you find the interiors of Masterstroke to be too dark."
	
func _on_ultrawide_dropdown_mouse_entered():
	descriptionLabel.text = "This option allows you to enable or disable add-ons that make the modlist compatible with ultrawide monitors. Make sure you select the correct aspect ratio for your monitor.\n\nAlso, make sure your resolution is set correctly in BethINI and the SSE Display Tweaks INI."

func _on_skin_dropdown_mouse_entered():
	descriptionLabel.text = "This option allows you to change the default female skin texture used by the modlist."

func _on_option_button_mouse_entered():
	descriptionLabel.text = "This option allows you to switch the profile of the modlist. By default, Masterstroke has two profiles: Regular, and Creature. Select a profile for more details about the selected profile."

func get_version(file_path):
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		
		var prefix = "-Masterstroke v"
		var suffix = "_separator"
		var version = ""
		
		while not file.eof_reached():
			var line = file.get_line()
			if line.begins_with(prefix) and line.ends_with(suffix):
				version = line
		
		file.close()
		
		version = version.trim_prefix(prefix)
		version = version.trim_suffix(suffix)
		return version
	else:
		return "null"


func _on_mcm_button_mouse_entered():
	descriptionLabel.text = "Opens the MCM configuration page for Masterstroke. Remember that without following these instructions while in-game, the list will not function correctly."


func _on_mcm_button_pressed():
	OS.shell_open("https://www.fgsmodlists.com/docs/masterstroke/post-install/mcm/")


func _on_skimpy_male_checkbox_toggled(_button_pressed):
	var profilePath = get_profile_path()
	
	if skimpyMale == false:
		find_and_replace(profilePath, "-Masterstroke Bodyslides (Skimpy Male)", "+Masterstroke Bodyslides (Skimpy Male)")
		descriptionLabel.text = "Enabled Skimpy Male Bodyslides."
		skimpyMale = true
	elif skimpyMale == true:
		find_and_replace(profilePath, "+Masterstroke Bodyslides (Skimpy Male)", "-Masterstroke Bodyslides (Skimpy Male)")
		descriptionLabel.text = "Disabled Skimpy Male Bodyslides."
		skimpyMale = false
	
	configFile.set_value("General", "male_skimpy", skimpyMale)
	configFile.save(configFilePath)

func _on_skimpy_female_checkbox_toggled(_button_pressed):
	var profilePath = get_profile_path()
	
	if skimpyFemale == false:
		find_and_replace(profilePath, "-Masterstroke Bodyslides (Skimpy Female)", "+Masterstroke Bodyslides (Skimpy Female)")
		descriptionLabel.text = "Enabled Skimpy Female Bodyslides."
		skimpyFemale = true
	elif skimpyFemale == true:
		find_and_replace(profilePath, "+Masterstroke Bodyslides (Skimpy Female)", "-Masterstroke Bodyslides (Skimpy Female)")
		descriptionLabel.text = "Disabled Skimpy Female Bodyslides."
		skimpyFemale = false
		
	configFile.set_value("General", "female_skimpy", skimpyFemale)
	configFile.save(configFilePath)

func _on_skimpy_male_checkbox_mouse_entered():
	descriptionLabel.text = "Toggles skimpy male outfit bodyslides on or off."


func _on_skimpy_female_checkbox_mouse_entered():
	descriptionLabel.text = "Toggles skimpy female outfit bodyslides on or off."

func _on_launch_wj_button_pressed():
	OS.create_process(wabbajackPath, [], false)


func _on_launch_wj_button_mouse_entered():
	descriptionLabel.text = "Launches Wabbajack so you can either update the list or re-install it."


func _on_install_location_button_pressed():
	fileDialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	fileDialog.visible = true
	fileDialog.access = FileDialog.ACCESS_FILESYSTEM

func _on_install_location_button_mouse_entered():
	descriptionLabel.text = "Manually select the install folder for an existing Masterstroke installation. Make sure to select the folder containing ModOrganizer.exe!"


func _on_file_dialog_dir_selected(dir):
	basePath = dir
	mo2Path = dir + "/ModOrganizer.exe"
	bethIniPath = dir + "/tools/BethINI/BethINI.exe"
	enbOrgPath = dir + "/tools/ENB Organizer/ENB Organizer.exe"
	regularProfileLoadOrderPath = dir + "/profiles/Masterstroke/modlist.txt"
	creatureProfileLoadOrderPath = dir + "/profiles/Masterstroke (Creature Profile)/modlist.txt"
	creatureProfileSavesPath = dir + "/profiles/Masterstroke (Creature Profile)/saves"
	regularProfileSavesPath = dir + "/profiles/Masterstroke/saves"
	
	configFile.set_value("Paths", "basePath", basePath)
	configFile.set_value("Paths", "mo2Path", mo2Path)
	configFile.set_value("Paths", "bethIniPath", bethIniPath)
	configFile.set_value("Paths", "enbOrgPath", enbOrgPath)
	configFile.set_value("Paths", "regularProfilePath", regularProfileLoadOrderPath)
	configFile.set_value("Paths", "creatureProfilePath", creatureProfileLoadOrderPath)
	configFile.set_value("Paths", "regularSavePath", regularProfileSavesPath)
	configFile.set_value("Paths", "creatureSavePath", creatureProfileSavesPath)
	configFile.save(configFilePath)
	
	advancedMode = false
	mo2Button.visible = false
	bethIniButton.visible = false
	installLocationButton2.visible = false
	
	_ready()

func _on_install_location_button_2_pressed():
	fileDialog.file_mode = FileDialog.FILE_MODE_OPEN_DIR
	fileDialog.visible = true
	fileDialog.access = FileDialog.ACCESS_FILESYSTEM

func _on_install_location_button_2_mouse_entered():
	descriptionLabel.text = "Manually select the install folder for an existing Masterstroke installation. Make sure to select the folder containing ModOrganizer.exe!"

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				dragpoint = Vector2i(get_global_mouse_position())
			else:
				dragpoint = null
	
	if event is InputEventMouseMotion and dragpoint != null:
		DisplayServer.window_set_position(get_window().get_position() + Vector2i(get_global_mouse_position()) - dragpoint)


func _on_minimize_button_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func _on_skin_dropdown_focus_exited():
	skinPreview.visible = false

func _on_skin_dropdown_focus_entered():
	skinPreview.visible = true
	match skinDropdown.selected:
		0:
			skinPreview.texture = load("res://Skins/FairSkin.tres")
		1:
			skinPreview.texture = load("res://Skins/Leyenda.tres")
		2:
			skinPreview.texture = load("res://Skins/LeyendaMusc.tres")
		3:
			skinPreview.texture = load("res://Skins/Demoniac.tres")
		4:
			skinPreview.texture = load("res://Skins/Diamond.tres")
		5:
			skinPreview.texture = load("res://Skins/ThePure.tres")
		6:
			skinPreview.texture = load("res://Skins/PrideOfValhalla.tres")


func _on_brighter_int_dropdown_focus_exited():
	skinPreview.visible = false


func _on_brighter_int_dropdown_focus_entered():
	skinPreview.visible = true
	skinPreview.texture = load("res://Skins/BrighterCompare.tres")


func _on_browse_folders_button_mouse_entered():
	descriptionLabel.text = "Toggle the folder browser menu."


func _on_browse_folders_button_pressed():
	if !folderMode:
		folderMode = true
		profileDropdown.visible = false
		profileLabel.visible = false
		advancedCheckButton.visible = false
		skinLabel.visible = false
		skinDropdown.visible = false
		brighterIntLabel.visible = false
		brighterIntDropdown.visible = false
		ultrawideLabel.visible = false
		ultrawideDropdown.visible = false
		versionLabel.visible = false
		skimpyMaleBox.visible = false
		skimpyFemaleBox.visible = false
		launchButton.visible = false
		folderButtonsLabel.visible = true
		regularSavesButton.visible = true
		creatureSavesButton.visible = true
		stockGameButton.visible = true
		racemenuFolderButton.visible = true
		bodyslideFolderButton.visible = true
		crashlogFolderButton.visible = true
		spacer.visible = true
		mo2Button.visible = false
		bethIniButton.visible = false
		installLocationButton2.visible = false
	else:
		folderMode = false
		_ready()


func _on_regular_saves_button_pressed():
	var pathToOpen = basePath + "/profiles/Masterstroke/saves"
	OS.shell_show_in_file_manager(pathToOpen, true)


func _on_creature_saves_button_pressed():
	var pathToOpen = basePath + "/profiles/Masterstroke (Creature Profile)/saves"
	OS.shell_show_in_file_manager(pathToOpen, true)


func _on_stock_game_folder_button_pressed():
	var pathToOpen = basePath + "/Stock Game"
	OS.shell_show_in_file_manager(pathToOpen, true)


func _on_race_menu_presets_folder_button_pressed():
	var pathToOpen = basePath + "/mods/Masterstroke Custom RaceMenu Presets/SKSE/Plugins/CharGen/Presets"
	OS.shell_show_in_file_manager(pathToOpen, true)


func _on_bodyslide_presets_folder_button_pressed():
	var pathToOpen = basePath + "/mods/Masterstroke Custom Bodyslide Presets/CalienteTools/BodySlide/SliderPresets"
	OS.shell_show_in_file_manager(pathToOpen, true)


func _on_crash_logs_folder_button_pressed():
	var pathToOpen = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "/My Games/Skyrim Special Edition/SKSE"
	OS.shell_show_in_file_manager(pathToOpen, true)


func _on_regular_saves_button_mouse_entered():
	descriptionLabel.text = "Open the Regular Profile Saves folder, if it exists."


func _on_creature_saves_button_mouse_entered():
	descriptionLabel.text = "Open the Creature Profile Saves folder, if it exists."


func _on_stock_game_folder_button_mouse_entered():
	descriptionLabel.text = "Open Masterstroke's Stock Game folder."


func _on_race_menu_presets_folder_button_mouse_entered():
	descriptionLabel.text = "Open the RaceMenu Presets folder. This folder is where you should put any RaceMenu presets you have created or want to add to the list."


func _on_bodyslide_presets_folder_button_mouse_entered():
	descriptionLabel.text = "Open the BodySlide Presets folder. This folder is where you should put any BodySlide presets you have created or want to add to the list."


func _on_crash_logs_folder_button_mouse_entered():
	descriptionLabel.text = "Open the folder containing crash logs for Masterstroke."
