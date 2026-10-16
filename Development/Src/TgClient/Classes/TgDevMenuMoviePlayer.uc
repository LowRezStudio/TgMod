class TgDevMenuMoviePlayer extends UIMoviePlayer
    native
    config(UI);

var GFxObject m_DevMenu;

native function FillMenuCommands();  // Export UTgDevMenuMoviePlayer::execFillMenuCommands(FFrame&, void* const)

native function FillSubMenuCommands(string submenuname);  // Export UTgDevMenuMoviePlayer::execFillSubMenuCommands(FFrame&, void* const)

native function AddCommand(string Section, string Command, string DisplayName);  // Export UTgDevMenuMoviePlayer::execAddCommand(FFrame&, void* const)

native function AddSubMenu(string Section, string submenuname, string DisplayName);  // Export UTgDevMenuMoviePlayer::execAddSubMenu(FFrame&, void* const)

function usc_FillCommands(string MenuName) { }

function PostInit() { }

event OnClose() { }

event bool FilterButtonInput(int ControllerId, name ButtonName, EInputEvent InputEvent) { }

defaultproperties
{
    MovieInfo=SwfMovie'DevMenu'
    Priority=100
}
