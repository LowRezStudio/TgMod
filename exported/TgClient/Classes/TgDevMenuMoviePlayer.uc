class TgDevMenuMoviePlayer extends UIMoviePlayer
    native
    config(UI);

var GFxObject m_DevMenu;

// Export UTgDevMenuMoviePlayer::execFillMenuCommands(FFrame&, void* const)
native function FillMenuCommands();

// Export UTgDevMenuMoviePlayer::execFillSubMenuCommands(FFrame&, void* const)
native function FillSubMenuCommands(string submenuname);

// Export UTgDevMenuMoviePlayer::execAddCommand(FFrame&, void* const)
native function AddCommand(string Section, string Command, string DisplayName);

// Export UTgDevMenuMoviePlayer::execAddSubMenu(FFrame&, void* const)
native function AddSubMenu(string Section, string submenuname, string DisplayName);

function usc_FillCommands(string MenuName)
{
    // End:0x1D
    if(MenuName == "")
    {
        FillMenuCommands();        
    }
    else
    {
        FillSubMenuCommands(MenuName);
    }
    //return;    
}

function PostInit()
{
    super.PostInit();    
    GetPlayerOwner().ConsoleCommand("FlashCaptureMouse");
    bCaptureMouseInput = true;
    bCaptureInput = true;
    //return;    
}

event OnClose()
{
    bCaptureMouseInput = false;
    bCaptureInput = false;    
    GetPlayerOwner().ConsoleCommand("FlashReleaseMouse");
    super.OnClose();
    //return;    
}

event bool FilterButtonInput(int ControllerId, name ButtonName, Object.EInputEvent Event)
{
    // End:0x84
    if(((ButtonName == 'XboxTypeS_B') || ButtonName == 'Escape') || ButtonName == 'XboxTypeS_BackLeft')
    {        
        GetPlayerOwner().ConsoleCommand("ToggleDevMenu");
        return true;
    }
    return super(GFxMoviePlayer).FilterButtonInput(ControllerId, ButtonName, Event);
    //return ReturnValue;    
}

defaultproperties
{
    MovieInfo=SwfMovie'DevMenu.DevMenu'
    Priority=100
}