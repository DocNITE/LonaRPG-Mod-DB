#==============================================================================
# ** Main entry file
# **
# ** Author: DocNight
#------------------------------------------------------------------------------
#  This file connect all scripts, what exist in '/src' folder.                            
#==============================================================================
 
# include script file
def import(path, file)
    load_script("ModScripts/_Mods/" + path + "/" + file);
end

#Game state var
$LGB_IS_GAME = false;


#Include project
import("LoadGameButton", "src/IMenuSystem.rb"       );
import("LoadGameButton", "src/ISceneLoad.rb"        );
import("LoadGameButton", "src/ISceneCustomLoad.rb"  );
import("LoadGameButton", "src/ITitleMenu.rb"        );