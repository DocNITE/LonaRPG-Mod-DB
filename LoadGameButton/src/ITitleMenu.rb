#==============================================================================
# ** Inject in original Title/Start menu
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

#Inject titlemenu
class TitleMenu < Sprite
	
    #Inject original method
	def initialize
		super(nil)
		create_foreground
		create_background
		tmpW = 320
		tmpH = Graphics.height
		self.bitmap = Bitmap.new(tmpW,tmpH)
		self.x = 0
		self.y = 57
		self.bitmap.font.name = System_Settings::MESSAGE_WINDOW_FONT_NAME
		self.bitmap.font.outline = false
		self.bitmap.font.bold = true
		self.z = System_Settings::TITLE_COMMAND_WINDOW_Z
		self.bitmap.font.size = 24
		#self.bitmap.font.name = ["Denk One"] if $lang == "ENG"
		@onBegin = true
		@optSymbol = {}
		@optNames = {}
		@optOptions = {}
		@optSettings = {}
		firstTimeBuildOPT
		draw_items
		if SceneManager.prevOptChoose != nil
			refresh_index(SceneManager.prevOptChoose)
		elsif DataManager.SaveFileExistsRGSS?
			refresh_index(1) #CONTINUE
		end
		@onBegin = false

        #Doc edit:
        $LGB_IS_GAME = false
	end

    def handlerCmdNewGame(value)
		return if @onBegin == true
		SndLib.closeChest
		$titleCreateActorReq = true
		if $TEST
			$game_map.setup($data_system.start_map_id)
			$game_player.moveto($data_system.start_x, $data_system.start_y)
			$game_map.interpreter.new_game_GetCommonSkills ##29_Functions_417
			$hudForceHide = false
			$balloonForceHide = false
		else
			$game_map.setup($data_tag_maps["TutorialOP"].sample)
			$game_player.moveto(0, 0)
			$hudForceHide = true
			$balloonForceHide = true
		end
		SceneManager.scene.fadeout_all
		SceneManager.prevOptChooseSet(nil)
		SceneManager.prevTitleOptChooseSet(nil)
		$game_map.interpreter.change_map_weather_cleaner
		$game_player.force_update = true
		$game_system.menu_disabled = false
		SceneManager.goto(Scene_Map)

        #Doc edit:
        $LGB_IS_GAME = true
	end
	
	def handlerCmdContinue(value)
		return if @onBegin == true
		SndLib.openChest
		@titleReqCacheClear = false
		$game_map.interpreter.chcg_background_color_off
		SceneManager.goto(Scene_Load)
	end
	
	def handlerCmdTLoadDoom(value)
		return if @onBegin == true
		SndLib.openChest
		$game_map.interpreter.chcg_background_color_off
		SceneManager.scene.gotoLoadCustomScene("SavDoomMode")
        
        #Doc edit:
        $LGB_IS_GAME = true
	end
	
	def handlerCmdTLoadAuto(value)
		return if @onBegin == true
		$game_map.interpreter.chcg_background_color_off
		SceneManager.scene.gotoLoadCustomScene("SavAuto")
        
        #Doc edit:
        $LGB_IS_GAME = true
	end

end