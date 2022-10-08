#==============================================================================
# ** Inject in original menu
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This inject class for main class in Data files                             
#==============================================================================

class Menu_System < Menu_ContentBase

    #Initializate menu buttons
    # Added: 
    #     create_load_game_sprite
    #     load_command_handler
    def create_sprites
		
		@info = Sprite.new(@viewport)
		@info.bitmap = Bitmap.new(Graphics.width, Graphics.height)
		@info.z = 2
		#[[			title_sprite,selection_sprites...], handler],[sprites, handler],	[sprites, handler]...				mouseEXT]
		@commands = []
		@commands << [create_save_game_sprite		,	method(:save_command_handler)		, nil								]
		@commands << [create_load_game_sprite		,	method(:load_command_handler)		, nil								]
		@commands << [create_return_to_title_sprite	,	method(:return_title_handler)		, nil								]
		@commands << [create_hardcore_sprite		,	method(:hardcore_opt_handler)		, method(:refresh_hard_core_opt)	]
		@commands << [create_scat_opt_sprite		,	method(:scat_opt_handler)			, method(:refresh_scat_opt)			]
		@commands << [create_urine_opt_sprite		,	method(:urine_opt_handler)			, method(:refresh_urine_opt)		]
		@commands << [create_fullscreen_opt_sprite	,	method(:fullscreen_opt_handler)		, method(:refresh_fullscreen_opt)	]
		@commands << [create_scale_opt_sprite		,	method(:scale_opt_handler)			, nil								]
		@commands << [create_SND_opt_sprite			,	method(:snd_opt_handler)			, nil								]
		@commands << [create_BGM_opt_sprite			,	method(:bgm_opt_handler)			, nil								]
		@commands << [create_HotkeyRoster_opt_sprite,	method(:hotkeyRoster_opt_handler)	, nil								]
		@commands << [create_KEY_opt_sprite			,	method(:key_opt_handler)			, nil								]
		#@commands << [@language_optArray				,	method(:launguage_opt_handler)	, method(:refresh_language_opt)		]
		#@commands.insert(@commands.length, [create_KEY_opt_sprite, method(:key_opt_handler), nil])
		#contents.insert(1,[$game_text["menu:core/sex_stats"]			,Menu_SexStats			])
		#contents.insert(1, [$game_text["menu:core/body_stats"]			,Menu_HealthStats		])
	end

    #Doc edit:
    #Load scene load (???!!!?!)
    def load_command_handler
        return SndLib.sys_buzzer if $story_stats["MenuSysSavegameOff"] >= 1
        SceneManager.goto(Scene_Load)
    end

    #Doc edit:
    #Create load button
	def create_load_game_sprite
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(160,30)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size=32
		spr.x = 198
		spr.y = 50
		spr.z = 3
		spr.bitmap.font.outline=false
		tmpTarText = "Load game"  #$game_text["menu:system/load_game"]
        if $lang == "RUS"
            tmpTarText = "Загрузить"
        elsif $lang == "ENG"
            tmpTarText = "Load game"
        elsif $lang == "MTL"
            tmpTarText = "Load game"
        end
		spr.bitmap.draw_text(spr.bitmap.rect,tmpTarText)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		if Mouse.usable?
			textWitdh = spr.bitmap.text_size(tmpTarText).width
			textHeight = spr.bitmap.text_size(tmpTarText).height
			@mouse_all_rects << [[spr.x, spr.y, textWitdh , textHeight]]
		end
		@all_sprites << spr
		[spr]
	end

    #Inject original method
    #Create save button
    # Added:
    #      Move spr.y position
    def create_save_game_sprite
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(160,30)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size=32
		spr.x = 198
		spr.y = 25
		spr.z = 3
		spr.bitmap.font.outline=false
		tmpTarText = $game_text["menu:system/save_game"]
		spr.bitmap.draw_text(spr.bitmap.rect,tmpTarText)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		if Mouse.usable?
			textWitdh = spr.bitmap.text_size(tmpTarText).width
			textHeight = spr.bitmap.text_size(tmpTarText).height
			@mouse_all_rects << [[spr.x, spr.y, textWitdh , textHeight]]
		end
		@all_sprites << spr
		[spr]
	end

    #Inject original method
    #Create return to title button
    # Added:
    #      Move spr.y position
    def create_return_to_title_sprite
		spr=Sprite.new(@viewport)
		spr.bitmap=Bitmap.new(240,30)
		spr.bitmap.font.color.set(*FONT_COLOR)
		spr.bitmap.font.size=32
		spr.x = 198
		spr.y = 74
		spr.z = 3
		spr.bitmap.font.outline=false
		tmpTarText = $game_text["menu:system/return_to_title"]
		spr.bitmap.draw_text(spr.bitmap.rect,tmpTarText)
		spr.visible=true
		spr.opacity=OPACITY_INACTIVE
		if Mouse.usable?
			textWitdh = spr.bitmap.text_size(tmpTarText).width
			textHeight = spr.bitmap.text_size(tmpTarText).height
			@mouse_all_rects << [[spr.x, spr.y, textWitdh , textHeight]]
		end
		@all_sprites << spr
		[spr]
	end

end