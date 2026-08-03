class TgControlModule_StunDisoriented extends TgControlModule_Stunned;

var int m_nInitialYaw;
var int m_nTargetYaw;
var const float m_fInterpTime;
var float m_fRemainingInterpTime;

function OnBecomeActive(TgControlModule OldModule)
{
    local Vector Loc;
    local Rotator Rot;

    Controller.GetPlayerViewPoint(Loc, Rot);
    m_nInitialYaw = Rot.Yaw;
    m_fRemainingInterpTime = m_fInterpTime;
    m_nTargetYaw = int(RandRange(0.0000000, 65536.0000000));
    //return;    
}

function UpdateRotation(float DeltaTime)
{
    local Rotator NewRotation, InitialRotation;
    local bool bFixedPitchMode;

    // End:0x11
    if(Controller == none)
    {
        return;
    }
    bFixedPitchMode = IsFixedPitchMode();
    NewRotation = Controller.Rotation;
    // End:0xAF
    if(!bFixedPitchMode)
    {
        NewRotation.Pitch = int(Controller.PlayerInput.aLookUp);
    }
    InitialRotation = NewRotation;
    InitialRotation.Yaw = m_nInitialYaw;
    NewRotation.Yaw = m_nTargetYaw;
    NewRotation = RLerp(NewRotation, InitialRotation, m_fRemainingInterpTime / m_fInterpTime, true);
    Controller.SetRotation(NewRotation);
    // End:0x215
    if(Controller.Pawn != none)
    {
        Controller.Pawn.SetDesiredRotation(NewRotation);
        Controller.Pawn.FaceRotation(NewRotation, DeltaTime);
    }
    // End:0x24D
    if(m_fRemainingInterpTime > 0.0000000)
    {
        m_fRemainingInterpTime = FMax(m_fRemainingInterpTime - DeltaTime, 0.0000000);
    }
    //return;    
}

defaultproperties
{
    m_fInterpTime=0.1500000
}