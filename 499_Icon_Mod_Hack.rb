#==============================================================================
# This script placed in core modAPI(ModScripts) scripts.
#==============================================================================
#==============================================================================
#  This file reverse more methods, where game use 'iconset.png'. 
# So, that script add feature - now you can use you're own icon 24x24.
#------------------------------------------------------------------------------
# Author: DocNight
#==============================================================================


#My question:
#==============================================================================
# -> Eccma417... Why are you gay?
#==============================================================================


#==============================================================================
# ** Map_Hud
#    Script : Scripts/Frames/102_01_map_hud.rb
#==============================================================================
class Map_Hud
    #--------------------------------------------------------------------------
    # * Draw Hotkey Icon (Reversed)
    #--------------------------------------------------------------------------
	def draw_hotkey_icon(original_bitmap,hotkey_sprite,skill_id,sort_index,sym)
        if skill_id.nil?
            icon_index = -1
        elsif skill_id==-1 || !@actor.can_set_skill?($data_skills[skill_id])
            icon_index = 717
        elsif skill_id == 61 #ext1
            icon_index = @player.actor.ext_item1.nil? ? -1 : @player.actor.ext_item1.icon_index
        elsif skill_id == 62 #ext2
            icon_index = @player.actor.ext_item2.nil? ? -1 : @player.actor.ext_item2.icon_index
        else
            icon_index=$data_skills[skill_id].icon_index
        end
        if icon_index.is_a?(String)
            if skill_id.nil?
                return
            end

            @cachedBitmapICON = Cache.normal_bitmap(icon_index)

            icon_src_rect = Rect.new(0, 0, 24, 24)
            board_src_rect= Rect.new(sort_index * 27, 0, 24, 32)
            hotkey_sprite.bitmap.fill_rect(board_src_rect,Color.new(255,255,255,0))
            hotkey_sprite.bitmap.blt(sort_index * 27 , 0 ,@cachedBitmapICON , icon_src_rect)
            hotkey_sprite.bitmap.blt(sort_index * 27 , 0 , original_bitmap, board_src_rect)  # CAUTION

            if @roster_need_display
                skillRosterIcon = 641 + @player.slot_RosterCurrent
                skillRosterIcon_src_rect = Rect.new(0, 0, 24, 24)
                hotkey_sprite.bitmap.blt(sort_index * 27  , 0 ,@cachedBitmapICON , skillRosterIcon_src_rect)
            end

            hotkey_sprite.bitmap.font.size = 14
            hotkey_sprite.bitmap.font.color.set(255,255,255,180)
            hotkey_sprite.bitmap.draw_text(sort_index * 27, 8,24,30,sym,1)
        else
            @cachedBitmapICON = Cache.system("Iconset")
            icon_src_rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
            board_src_rect= Rect.new(sort_index * 27, 0, 24, 32)
            hotkey_sprite.bitmap.fill_rect(board_src_rect,Color.new(255,255,255,0))
            hotkey_sprite.bitmap.blt(sort_index * 27 , 0 ,@cachedBitmapICON , icon_src_rect) if icon_index !=-1
            hotkey_sprite.bitmap.blt(sort_index * 27 , 0 , original_bitmap, board_src_rect)
            if @roster_need_display
                skillRosterIcon = 641 + @player.slot_RosterCurrent
                skillRosterIcon_src_rect = Rect.new(skillRosterIcon % 16 * 24, skillRosterIcon / 16 * 24, 24, 24)
                hotkey_sprite.bitmap.blt(sort_index * 27  , 0 ,@cachedBitmapICON , skillRosterIcon_src_rect)
            end
            return if icon_index == -1
            hotkey_sprite.bitmap.font.size = 14
            hotkey_sprite.bitmap.font.color.set(255,255,255,180)
            hotkey_sprite.bitmap.draw_text(sort_index * 27, 8,24,30,sym,1)
        end
	end

end 
#Map_Hud

#==============================================================================
# ** Menu_HealthStats
#    Script : Scripts/Frames/176_menu_02healthstats.rb
#==============================================================================
class Menu_HealthStats < Menu_ContentBase
    #--------------------------------------------------------------------------
    # * Refresh Buff Icons (Reversed)
    #--------------------------------------------------------------------------
	def refresh_buff_icons
		#@buff_icons.bitmap.dispose if @buff_icons.bitmap
		@states=@actor.states.uniq.select{
			|state|
			!["trait","combat","","nil",nil].include?(state.type_tag)
		}.sort{
			|state1,state2|
			sort_order = ["daily","green", "yellow", "red", "magenta"]
			sort_order.index(state1.type_tag) < sort_order.index(state2.type_tag) ? -1 : 1
		}
		states_length = @states.length>0 ? @states.length : 1
		@buff_icons.bitmap = Bitmap.new(130, 27 * states_length)
		@buff_icons.bitmap.font.outline=false
		@buff_icon_rect_record = []
		@states.each_with_index{
			|state,index|
			case state.type_tag
			when "daily";			@buff_icons.bitmap.font.color=Color.new(20,255,255,255)
			when "green";			@buff_icons.bitmap.font.color=Color.new(10,255,10,255)
			when "yellow";			@buff_icons.bitmap.font.color=Color.new(255,255,0,255)
			when "red"	;			@buff_icons.bitmap.font.color=Color.new(255,30,30,255)
			when "magenta";			@buff_icons.bitmap.font.color=Color.new(255,0,255,255)
			else;break;
			end
			@buff_icons.bitmap.font.size=16
			draw_text_on_canvas(@buff_icons, 13+21, 27 * index-3, state.name ,true)
			@buff_icons.bitmap.font.size=12
			@buff_icons.bitmap.draw_text(0, 27 * index+ 11 , 123, 16, "stack : #{@actor.state_stack(state.id)}", 2)
            if state.icon_index.is_a?(String)
                @buff_icons.bitmap.blt(8, index*27, Cache.normal_bitmap(state.icon_index), Rect.new(0, 0, 24, 24))
            else
			    @buff_icons.bitmap.blt(8, index*27, Cache.system("Iconset"), Rect.new(state.icon_index  % 16 * 24, state.icon_index / 16 * 24, 24, 24))
            end
			@buff_icon_rect_record << [@icon_viewport_default_x, @icon_viewport_default_y+27 * index, 123 , 32] if @buff_icon_rect_record.size < 11
		}
	end
  
end 
#Menu_HealthStats

#==============================================================================
# ** Menu_Traits
#    Script : Scripts/Frames/182_menu_04traits.rb
#==============================================================================
class Menu_Traits < Menu_ContentBase
    #--------------------------------------------------------------------------
    # * Create Gift Trait List (Reversed)
    #--------------------------------------------------------------------------
	def create_gift_trait_list
		@mouse_gift_trait_rect = []
		@gift_trait_icons=Array.new(@gift_traits.size){
			|index|
			trait_id = @gift_traits[index]
			next if trait_id.nil?
			spr=Sprite.new(@viewport)
			icon_index=$data_states[trait_id].icon_index
			bmp=Bitmap.new(26,26)
            if icon_index.is_a?(String)
                bmp.blt(1,1,Cache.normal_bitmap(icon_index),Rect.new(0, 0, 24, 24))
            else
			    bmp.blt(1,1,Cache.system("Iconset"),Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24))
            end

			spr.bitmap = bmp;
			spr.x= 365+ index % 9 * 26;
			spr.y= 67 + (index / 9 * 26); #edit
			@mouse_gift_trait_rect << [spr.x,spr.y,26,26]
			spr
		}
		@gift_trait_icons
	end

end 
#Menu_Traits

#==============================================================================
# ** Menu_Quests
#    Script : Scripts/Frames/187_menu_05quests_Menu.rb
#==============================================================================
class Menu_Quests < Menu_ContentBase
      #--------------------------------------------------------------------------
      # * Create Category (Reversed)
      #--------------------------------------------------------------------------
      def create_category_sprite
          @mouse_category_rect = []
          @category_sprites = Array.new(4){Sprite.new(@viewport)}
          @category_sprites.each_with_index do |spr, index|
              spr.bitmap = Bitmap.new(24,24)
              icon_index = icons[icons.keys[index]]
              bmp = -1
              rect = -1
              if icon_index.is_a?(String)
                bmp = Cache.normal_bitmap(icon_index)
                rect = Rect.new(0, 0, 24, 24)
              else
                bmp = Cache.system("Iconset")
                rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
              end
              spr.bitmap.blt(0, 0, bmp, rect)
              spr.opacity = 128
              spr.x, spr.y = 164 + index * 30, 29
              @mouse_category_rect << [spr.x,spr.y,24,24]
          end  
      end
      
end 
#Menu_Quests

#==============================================================================
# ** Menu_Equips
#    Script : Scripts/Frames/188_menu_06equips.rb
#==============================================================================
class Menu_Equips < Menu_ContentBase
    #--------------------------------------------------------------------------
    # * Draw Icon (Reversed)
    #--------------------------------------------------------------------------
    def draw_icon(bmp, x, y, index, enabled = true)
        if index.is_a?(String)
            rect = Rect.new(0, 0, 24, 24)
            bmp.blt(x, y, Cache.normal_bitmap(index), rect, enabled ? 255 : 192)
        else
            rect = Rect.new((index % 16 * 24), (index / 16 * 24), 24, 24)
            bmp.blt(x, y, Cache.system("Iconset"), rect, enabled ? 255 : 192)
        end
    end
  
end 
#Menu_Equips

#==============================================================================
# ** Menu_Items
#    Script : Scripts/Frames/191_menu_07items.rb
#==============================================================================
class Menu_Items < Menu_ContentBase
    #--------------------------------------------------------------------------
    # * Refresh Items (Reversed)
    #--------------------------------------------------------------------------
	def refresh_contents(id = nil)
		@mouse_items_rect = []
		sprite=@contents[@category_index]
		case @category_index
			when 0; category = item_foods
			when 1; category = item_medicine
			when 2; category = item_equips
			when 3; category = item_other
		end
		if category.size==0
			sprite.bitmap.clear if sprite.bitmap
			return
		end
		sprite.bitmap = Bitmap.new(@list_viewport.rect.width, 26*(category.size+1/2))
		for i in 0...category.length
			item = category[i]
			case item.type
				when "Food";sprite.bitmap.font.color= Color.new(20,255,20);				#green  
				when "Medicine";sprite.bitmap.font.color= Color.new(0,255,255); 		#cyan   
				when "Weapon","Armor";sprite.bitmap.font.color= Color.new(120,120,255);	#blue   
			else
				sprite.bitmap.font.color=Color.new(255,255,0)#yellow 
			end
			row = i/2
			column = i%2		
			#x = 47 + 211*column
			#y = 26 * row
			x = 25 + 211*column
			y = 26 * row
			@mouse_items_rect << [x+180,y+78,@select_block1.width,@select_block1.height] ## start at 180,78
			sprite.bitmap.font.outline=false
			sprite.bitmap.font.size = 16
			sprite.bitmap.draw_text(x+29 ,y-3 ,192,20,category[i].name)
			#draw_text_on_canvas(sprite, x+29 ,y ,category[i].name,true)#name
            sprite.bitmap.font.size = 12
            if item.icon_index.is_a?(String)
                rect = Rect.new(0, 0, 24, 24)
                sprite.bitmap.blt(x, y, Cache.normal_bitmap(item.icon_index), rect,  @actor.usable?(item) ? 255 : 192)
            else
                rect = Rect.new(item.icon_index % 16 * 24, item.icon_index / 16 * 24, 24, 24)
                sprite.bitmap.blt(x, y, Cache.system("Iconset"), rect,  @actor.usable?(item) ? 255 : 192)
            end
			sprite.bitmap.draw_text(x, y+12 , 130, 13, "WT : #{item.weight}", 2) #number
			sprite.bitmap.draw_text(x, y+12 , 180, 13, "NUM : #{$game_party.item_number(item)}", 2) #number
		end
	end
    #--------------------------------------------------------------------------
    # * Draw Icon (Reversed)
    #--------------------------------------------------------------------------
    def draw_icon(bmp, x, y, index, enabled = true)
        if index.is_a?(String)
            rect = Rect.new(0, 0, 24, 24)
            bmp.blt(x, y, Cache.normal_bitmap(index), rect, enabled ? 255 : 192)
        else
            rect = Rect.new((index % 16 * 24), (index / 16 * 24), 24, 24)
            bmp.blt(x, y, Cache.system("Iconset"), rect, enabled ? 255 : 192)
        end
    end
  
end 
#Menu_Items

#==============================================================================
# ** Menu_SkillAndHotkey
#    Script : Scripts/Frames/195_menu_09_skillsandhotkey.rb
#==============================================================================
class Menu_SkillAndHotkey < Menu_ContentBase
  #--------------------------------------------------------------------------
  # * Refresh Skill Icons (Reversed)
  #--------------------------------------------------------------------------
  def refresh_skill_icons
	@buff_icons.bitmap.dispose if @buff_icons.bitmap
	@skills=[$data_skills[101],$data_skills[102],$data_skills[103]] + @actor.usable_skills.select{|skill|skill.type.eql?("other")}
	@buff_icons.bitmap = Bitmap.new(130, 27 * @skills.length)
	@last_icon_index = @skills.size % 9
	@buff_icons.bitmap.font.size=16
	@buff_icons.bitmap.font.outline=false
	@buff_icons.bitmap.font.color.set(Color.new(255,255,0)) #417 COLOR
	@buff_icon_rect_record = []
	for index in 0...@skills.length
		skill=@skills[index]
        icon_index = real_skill_icon(skill);
		@buff_icon_rect_record << [@icon_viewport_default_x, @icon_viewport_default_y+27 * index, 123 , 32] if @buff_icon_rect_record.size < 9
		if skill.item_name == "sys_normal"
            equip_icon_index = getPlayerEquipIcon(0);
            if icon_index.is_a?(String)
                @buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
                if equip_icon_index.is_a?(String)
                    @buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
                else
                    @buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
                end
                draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, skill.name ,true)
            else
                @buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
                if equip_icon_index.is_a?(String)
                    @buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
                else
                    @buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
                end
                draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, skill.name ,true)
            end
		elsif skill.item_name == "sys_heavy"
            equip_icon_index = getPlayerEquipIcon(1);
            if icon_index.is_a?(String)
                @buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
                if equip_icon_index.is_a?(String)
                    @buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
                else
                    @buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
                end
                draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, skill.name ,true)
            else
                @buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
                if equip_icon_index.is_a?(String)
                    @buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
                else
                    @buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
                end
                draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, skill.name ,true)
            end
		elsif skill.item_name == "sys_control"
            equip_icon_index = getPlayerEquipIcon(1);
            if icon_index.is_a?(String)
                @buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
                if equip_icon_index.is_a?(String)
                    @buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
                else
                    @buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
                end
            else
			    @buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
                if equip_icon_index.is_a?(String)
                    @buff_icons.bitmap.blt(24, index*27, Cache.normal_bitmap(equip_icon_index), Rect.new(0, 0, 24, 24))
                else
                    @buff_icons.bitmap.blt(24, index*27, Cache.system("Iconset"), Rect.new(equip_icon_index % 16 * 24, equip_icon_index / 16 * 24, 24, 24))
                end
            end
			draw_text_on_canvas(@buff_icons, 5+21+24, 27 * index, skill.name ,true)
		else
			draw_text_on_canvas(@buff_icons, 5+21, 27 * index, skill.name ,true)
            if icon_index.is_a?(String)
                @buff_icons.bitmap.blt(0, index*27, Cache.normal_bitmap(icon_index), Rect.new(0, 0, 24, 24))
            else
			    @buff_icons.bitmap.blt(0, index*27, Cache.system("Iconset"), Rect.new(icon_index  % 16 * 24, icon_index / 16 * 24, 24, 24))
            end
        end
	end
  end
	
end 
#Menu_SkillAndHotkey

#==============================================================================
# ** Sprite_PopText
#    Script : Scripts/Frames/200_Galv_Event_Popup.rb
#==============================================================================
class Sprite_PopText < Sprite
    #--------------------------------------------------------------------------
    # * Draw icon (Reversed)
    #--------------------------------------------------------------------------
    def draw_icon(icon_index)
        if icon_index.is_a?(String)
            rect = Rect.new(0, 0, 24, 24)
            @icon_sprite.bitmap.dispose
            @icon_sprite.bitmap = Cache.normal_bitmap(icon_index);
            @icon_sprite.src_rect = rect
            @icon = icon_index
        else
            rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
            @icon_sprite.src_rect = rect
            @icon = icon_index
        end
    end
end 
#Sprite_PopText

#==============================================================================
# ** Spriteset_DamagePopups
#    Script : Scripts/Frames/205_DB_DamagePopup.rb
#==============================================================================
class Spriteset_DamagePopups
    #--------------------------------------------------------------------------
    # * Create icon (Reversed)
    #--------------------------------------------------------------------------
    def create_icon_bitmap(icon_index,src_bitmap)
        bitmap = -1;
        if icon_index.is_a?(String)
            bitmap = Bitmap.new(24,24)
            bitmap.blt(0,0,Cache.normal_bitmap(icon_index),Rect.new(0,0,24,24))
        else
            bitmap = Bitmap.new(24,24)
            bitmap.blt(0,0,src_bitmap,Rect.new(icon_index%16 * 24,icon_index /16 *24,24,24))
        end
        bitmap
    end
    #--------------------------------------------------------------------------
    # * Create Jump Dot icon (Reversed)
    #--------------------------------------------------------------------------
    def create_jumpDots_bitmap(icon_index,src_bitmap)
        bitmap = -1;
        if icon_index.is_a?(String)
            bitmap = Bitmap.new(3,3)
            bitmap.blt(0,0,Cache.normal_bitmap(icon_index),Rect.new(0,0,3,3))
        else
            bitmap = Bitmap.new(3,3)
            bitmap.blt(0,0,src_bitmap,Rect.new(icon_index%4 * 3,icon_index /4 *3,3,3))
        end
        bitmap
    end
    
end 
#Spriteset_DamagePopups

#==============================================================================
# ** Window_Base
#    Script : Scripts/Frames/53_Window_Base.rb
#==============================================================================
class Window_Base < Window
    #--------------------------------------------------------------------------
    # * Draw Icon
    #     enabled : Enabled flag. When false, draw semi-transparently.
    #--------------------------------------------------------------------------
    def draw_icon(icon_index, x, y, enabled = true)
        bitmap = -1
        rect = -1
        if icon_index.is_a?(String)
            bitmap = Cache.normal_bitmap(icon_index)
            rect = Rect.new(0, 0, 24, 24)
        else
            bitmap = Cache.system("Iconset")
            rect = Rect.new(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
        end
        contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
    end
end
