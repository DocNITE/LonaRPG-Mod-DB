#this DEMO mod is a DEMO to make a item named "CustomApple".
#you can clone armor and weapons if u know what ur doing.
#you can change other item stats if u know what ur doing.

#this DEMO mod will load "ModScripts/500_DEMO_ExtraEventLib.rvdata2" into EventLib.
#you can create a empty map. and write ur own event. or copy paste from event -lib-MapObject
#this mod will do overwrite if events got same name in -lib-MapObject.

#how to CREATE A EventLib.
	#create a new map through RMACE EDITOR.
	#create a event you want in this map.
	#save.
	#copy paste your map and rename to somewhere you like.
	#delete this map through  RMACE EDITOR.
	#save.
	#FileGetter.load_mod_EventLib("YourFolder/YourMap.rvdata2")

#Edit a Mod EventLib.
	#create a new map through RMACE EDITOR, and remember its map_id.
	#save, and close RMACE EDITOR
	#rename ur Event into Map"ID".rvdata2 and copy to Data\.
	#open RMACE EDITOR and load ur map.

#Summon this new event from EventLib.
	#f10
	#EvLib.sum("CustomApple")
	
module DataManager
	self.singleton_class.send(:alias_method, :load_mod_database_DEMO, :load_mod_database)
	def self.load_mod_database
		load_mod_database_DEMO
		$data_items << $data_ItemName["ItemApple"].clone 							#clone a APPLE to last item array, 
		$data_items.last.name = "CustomApple"										#change its name to "CustomApple"
		$data_items.last.id = $data_items.length-1									#create item ID to last array length
		$data_items.last.icon_index = 687											#change icon ID
		$data_items.last.load_lona_effect_from_json("medicine_HiPotionLV5.json")	#change effect json
		$data_items.last.price=8964													#change price
		$data_ItemName[$data_items.last.name] = $data_items.last					#write it to ItemName hash
		FileGetter.load_mod_EventLib("ModScripts/_Mods/DEMO_CreateNewItem/500_DEMO_ExtraEventLib.rvdata2")	#load a custom map into EventLib
	end
end