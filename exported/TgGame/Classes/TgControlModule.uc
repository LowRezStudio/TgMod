class TgControlModule extends Object
    abstract;

var TgPlayerController Controller;
var bool m_bIsActive;

function Init()
{
    //return;    
}

function OnBecomeActive(TgControlModule OldModule)
{
    m_bIsActive = true;
    //return;    
}

function OnBecomeInActive(TgControlModule NewModule)
{
    m_bIsActive = false;
    //return;    
}

function OnSettingsChanged(TgClientSettings Settings)
{
    //return;    
}

singular simulated function Rotator GetBaseAimRotation(Weapon W, optional bool bIgnoreAutoLock)
{
    //return ReturnValue;    
}

function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
{
    //return;    
}

function PlayerMove(float DeltaTime)
{
    //return;    
}

function UpdateRotation(float DeltaTime)
{
    //return;    
}

function OnRightMousePressed()
{
    //return;    
}

exec function OnRightMouseReleased()
{
    //return;    
}

function AdjustAimingView(out Vector ViewLocation, out Rotator ViewRotation)
{
    //return;    
}

function bool InterceptFlashInput(name ButtonName, Object.EInputEvent Event)
{
    return false;
    //return ReturnValue;    
}
