class GameUISceneClient extends UISceneClient within UIInteraction
    transient
    native(UIPrivate)
    config(UI)
    hidecategories(Object,UIRoot);

var const transient float LatestDeltaTime;
var const transient Double DoubleClickStartTime;
var const transient IntPoint DoubleClickStartPosition;
var native const transient Map_Mirror InitialPressedKeys;
var const transient bool bUpdateInputProcessingStatus;
var transient bool bUpdateSceneViewportSizes;
var config bool bEnableDebugInput;
var config bool bRenderDebugInfo;
var const config bool bCaptureUnprocessedInput;
var const transient array<name> NavAliases;
var const transient array<name> AxisInputKeys;

// Export UGameUISceneClient::execTgFlushPlayerInput(FFrame&, void* const)
native final function TgFlushPlayerInput();

// Export UGameUISceneClient::execGetCurrentNetMode(FFrame&, void* const)
native static final function WorldInfo.ENetMode GetCurrentNetMode();

// Export UGameUISceneClient::execRequestInputProcessingUpdate(FFrame&, void* const)
native final function RequestInputProcessingUpdate();

// Export UGameUISceneClient::execCanUnpauseInternalUI(FFrame&, void* const)
native final function bool CanUnpauseInternalUI();

event PauseGame(bool bDesiredPauseState, optional int PlayerIndex = 0)
{
    local PlayerController PlayerOwner;

    // End:0x170
    if(Outer.Outer.Outer.GamePlayers.Length > 0)
    {
        PlayerIndex = Clamp(PlayerIndex, 0, Outer.Outer.Outer.GamePlayers.Length - 1);
        PlayerOwner = Outer.Outer.Outer.GamePlayers[PlayerIndex].Actor;
        // End:0x170
        if(PlayerOwner != none)
        {
            PlayerOwner.SetPause(bDesiredPauseState, CanUnpauseInternalUI);
        }
    }
    //return;    
}

function NotifyClientTravel(PlayerController TravellingPlayer, string TravelURL, Actor.ETravelType TravelType, bool bIsSeamlessTravel)
{
    //return;    
}

function NotifyGameSessionEnded()
{
    //return;    
}

function NotifyPlayerAdded(int PlayerIndex, LocalPlayer AddedPlayer)
{
    // End:0x19
    if(IsUIActive(2))
    {
        RequestInputProcessingUpdate();
    }
    //return;    
}

function NotifyPlayerRemoved(int PlayerIndex, LocalPlayer RemovedPlayer)
{
    // End:0x19
    if(IsUIActive(2))
    {
        RequestInputProcessingUpdate();
    }
    //return;    
}

function int FindLocalPlayerIndex(Player P)
{
    local Engine Engine;
    local int I;

    Engine = Class'Engine.Engine'.static.GetEngine();
    I = 0;
    J0x34:

    // End:0xAF [Loop If]
    if(I < Engine.GamePlayers.Length)
    {
        // End:0xA1
        if(Engine.GamePlayers[I] == P)
        {
            return I;
        }
        I++;
        // [Loop Continue]
        goto J0x34;
    }
    return 0;
    //return ReturnValue;    
}

defaultproperties
{
    bEnableDebugInput=true
    NavAliases[0]="UIKEY_NavFocusUp"
    NavAliases[1]="UIKEY_NavFocusDown"
    NavAliases[2]="UIKEY_NavFocusLeft"
    NavAliases[3]="UIKEY_NavFocusRight"
    AxisInputKeys[0]="KEY_Gamepad_LeftStick_Up"
    AxisInputKeys[1]="KEY_Gamepad_LeftStick_Down"
    AxisInputKeys[2]="KEY_Gamepad_LeftStick_Right"
    AxisInputKeys[3]="KEY_Gamepad_LeftStick_Left"
    AxisInputKeys[4]="KEY_Gamepad_RightStick_Up"
    AxisInputKeys[5]="KEY_Gamepad_RightStick_Down"
    AxisInputKeys[6]="KEY_Gamepad_RightStick_Right"
    AxisInputKeys[7]="KEY_Gamepad_RightStick_Left"
    AxisInputKeys[8]="KEY_SIXAXIS_AccelX"
    AxisInputKeys[9]="KEY_SIXAXIS_AccelY"
    AxisInputKeys[10]="KEY_SIXAXIS_AccelZ"
    AxisInputKeys[11]="KEY_SIXAXIS_Gyro"
    AxisInputKeys[12]="KEY_XboxTypeS_LeftX"
    AxisInputKeys[13]="KEY_XboxTypeS_LeftY"
    AxisInputKeys[14]="KEY_XboxTypeS_RightX"
    AxisInputKeys[15]="KEY_XboxTypeS_RightY"
}