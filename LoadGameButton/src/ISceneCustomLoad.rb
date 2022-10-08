#==============================================================================
# ** Inject in original custom load menu
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#Inject customModeLoad
class Scene_CustomModeLoad < Scene_MenuBase
	
	def customSaveLoad
		if DataManager.customModeLoad(DataManager.customLoadName)
			on_load_success 
		else
			SndLib.sys_buzzer
			SceneManager.goto(Scene_Map)
            $LGB_IS_GAME = true;
		end
	end
	
	def doomSaveCancel
		SceneManager.goto(Scene_MapTitle)
        $LGB_IS_GAME = false;
		SndLib.ppl_BooGroup(100)
	end

	def on_load_success
		Cache.clear
		$titleCreateActorReq = true
		if @doomMode
			SndLib.ppl_CheerGroup(100)
		else
			SndLib.sys_LoadGame
		end
		SceneManager.prevOptChooseSet(nil)
		SceneManager.prevTitleOptChooseSet(nil)
		fadeout_all
		$game_system.on_after_load
		SceneManager.goto(Scene_Map)
        $LGB_IS_GAME = true;
		$game_player.refresh_chs
		File.delete("SavDoomMode.rvdata2") if DataManager.SaveFileExistsDOOM? && @doomMode
	end
end