class TgControlModule_StunTaunted extends TgControlModule_ThirdPerson
    config(Engine);

var float m_fInitialYaw;
var const float m_fInterpTime;
var float m_fRemainingInterpTime;

function OnBecomeActive(TgControlModule OldModule) { }

function OnBecomeInActive(TgControlModule NewModule) { }

function Vector CalcNewAccel() { }

function UpdateRotation(float DeltaTime) { }

defaultproperties
{
    m_fInterpTime=0.1500000
}
