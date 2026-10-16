class TgGameViewportClient extends PComGameViewportClient within Engine
    transient
    native
    config(Engine);

var array<TgObjectReferencer> m_DeferredManifests;
var bool m_dragging;
var bool m_wasMaximized;
var transient bool bReadLeftStickAxis;
var transient bool bReadRightStickAxis;
var transient float fRawLeftStickAxis;
var transient float fRawRightStickAxis;

function DrawTransition(Canvas Canvas)
{
    //return;    
}

// Export UTgGameViewportClient::execNativeGameSessionEnded(FFrame&, void* const)
native function NativeGameSessionEnded();

// Export UTgGameViewportClient::execIsGfxMovieCapturingMouseInput(FFrame&, void* const)
native function bool IsGfxMovieCapturingMouseInput();

// Export UTgGameViewportClient::execInitTgGameViewportClient(FFrame&, void* const)
native function InitTgGameViewportClient();

event GameSessionEnded()
{
    local TgSpectatorController SpectatorPC;

    super(GameViewportClient).GameSessionEnded();
    NativeGameSessionEnded();
    // End:0xDC
    if(Outer.GamePlayers.Length > 0)
    {
        SpectatorPC = TgSpectatorController(Outer.GamePlayers[0].Actor);
        // End:0xDC
        if((SpectatorPC != none) && int(SpectatorPC.m_CameraMode) != int(1))
        {
            SpectatorPC.SetNewSpectatorMode(0);
        }
    }
    //return;    
}

event PostRender(Canvas Canvas)
{
    local TgPlayerController PC;
    local TgGameHUD HUD;

    super(GameViewportClient).PostRender(Canvas);
    // End:0x189
    if(Outer.GamePlayers.Length > 0)
    {
        PC = TgPlayerController(Outer.GamePlayers[0].Actor);
        // End:0x189
        if((PC != none) && TgGameHUD(PC.myHUD) != none)
        {
            HUD = TgGameHUD(PC.myHUD);
            // End:0x189
            if((HUD.m_TargetingMap != none) && HUD.m_TargetingMap.ShouldRender())
            {
                HUD.m_TargetingMap.Draw(Canvas);
            }
        }
    }
    //return;    
}

event GetSubtitleRegion(out Vector2D MinPos, out Vector2D MaxPos)
{
    MaxPos.X = 1.0000000;
    MaxPos.Y = ((Outer.GamePlayers.Length == 1) ? 0.7400000 : 0.5000000);
    //return;    
}

event LayoutPlayers()
{
    local LocalPlayer LocalPlayer;

    // End:0x111
    foreach Outer.GamePlayers(LocalPlayer)
    {
        // End:0x9E
        if(LocalPlayer.Size.X == 0.0000000)
        {
            LocalPlayer.Size.X = 1.0000000;
        }
        // End:0x110
        if(LocalPlayer.Size.Y == 0.0000000)
        {
            LocalPlayer.Size.Y = 1.0000000;
        }        
    }    
    //return;    
}

event bool Init(out string OutError)
{
    InitTgGameViewportClient();
    return super.Init(OutError);
    //return ReturnValue;    
}
