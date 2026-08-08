class UIHudVGS extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const VGS_MAP_PC = 1;

const VGS_MAP_CONSOLE = 4;

const VGS_LIST_COUNT = 14;

const VGS_GAMEPAD_COUNT = 6;

enum VGS_GamepadItem {
    VGSGP_L,  // 0
    VGSGP_R,  // 1
    VGSGP_Y,  // 2
    VGSGP_X,  // 3
    VGSGP_B,  // 4
    VGSGP_A,  // 5
};

var GFxObject m_Label[14];
var GFxObject m_Keybind[14];
var GFxObject m_ListItem[14];
var GFxObject m_GamepadItem[6];
var GFxObject m_FramePC;
var GFxObject m_FrameConsole;
var UIHudVGSData m_pRootPC;
var UIHudVGSData m_pRootConsole;
var UIHudVGSData m_pCurrent;
var bool m_bIsGamepadSequence;

delegate usc_ForceInput_Delegate();

native function usc_ForceInput(string Input);  // Export UUIHudVGS::execusc_ForceInput(FFrame&, void* const)

defaultproperties
{
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudVGS"
}
