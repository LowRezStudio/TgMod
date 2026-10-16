class TgControlModule_SpectatorLockedView extends TgControlModule_Spectator
    config(Input);

var const config float DirectorModeSpectatorStallZ;
var const config float DirectorModeSpectatorMinStallZ;

function float GetMaxStallZ()
{
    local TgDemoRecSpectator DemoPC;

    DemoPC = TgDemoRecSpectator(Controller);
    // End:0x94
    if(((DemoPC != none) && DemoPC.m_SpectatorDirector != none) && DemoPC.m_SpectatorDirector.IsCurrentlyViewing())
    {
        return DirectorModeSpectatorStallZ;
    }
    return SpectatorStallZ;
    //return ReturnValue;    
}

function float GetMinStallZ()
{
    local TgDemoRecSpectator DemoPC;

    DemoPC = TgDemoRecSpectator(Controller);
    // End:0x94
    if(((DemoPC != none) && DemoPC.m_SpectatorDirector != none) && DemoPC.m_SpectatorDirector.IsCurrentlyViewing())
    {
        return DirectorModeSpectatorMinStallZ;
    }
    return SpectatorMinStallZ;
    //return ReturnValue;    
}

function PlayerMove(float DeltaTime)
{
    local Vector X, Y, Z, newAccel, Loc;

    local Rotator Rot;
    local TgPlayerController TgPC;

    TgPC = Controller;
    // End:0x24
    if(TgPC == none)
    {
        return;
    }
    DeltaTime = TgPC.WorldInfo.m_fRealDeltaSeconds;
    TgPC.UpdateRotation(DeltaTime);
    TgPC.GetPlayerViewPoint(Loc, Rot);
    GetAxes(MakeRotator(0, Rot.Yaw, 0), X, Y, Z);
    newAccel = (Controller.PlayerInput.aForward * X) + (Controller.PlayerInput.aStrafe * Y);
    newAccel.Z = Controller.PlayerInput.aUp;
    // End:0x243
    if(int(TgPC.Role) < int(ROLE_Authority))
    {
        TgPC.ReplicateMove(DeltaTime, newAccel, 0, rot(0, 0, 0));        
    }
    else
    {
        TgPC.ProcessMove(DeltaTime, newAccel, 0, rot(0, 0, 0));
    }
    //return;    
}
