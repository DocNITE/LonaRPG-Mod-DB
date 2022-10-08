#==============================================================================
# ** Inject in original load menu
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#Inject load scene class
class Scene_Load < Scene_File
  
    #Inject original method
    def on_load_success
		$titleCreateActorReq = true
		SceneManager.prevOptChooseSet(nil)
		SceneManager.prevTitleOptChooseSet(nil)
		SndLib.sys_LoadGame
		fadeout_all
		$game_system.on_after_load
		SceneManager.goto(Scene_Map)
		$game_player.refresh_chs

        #Doc edit:
        $LGB_IS_GAME = true
	end

    #Inject original method
	def on_savefile_cancel
		SndLib.sys_cancel
        if $LGB_IS_GAME == false
		    SceneManager.goto(Scene_MapTitle)
        else
            SceneManager.goto(Scene_Menu)
        end
	end

end