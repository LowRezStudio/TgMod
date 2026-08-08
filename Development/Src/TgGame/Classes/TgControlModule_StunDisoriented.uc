class TgControlModule_StunDisoriented extends TgControlModule_Stunned
    config(Engine);

var int m_nInitialYaw;
var int m_nTargetYaw;
var const float m_fInterpTime;
var float m_fRemainingInterpTime;

function OnBecomeActive(TgControlModule OldModule) { }

function UpdateRotation(float DeltaTime) { }

defaultproperties
{
    m_fInterpTime=0.1500000
}
