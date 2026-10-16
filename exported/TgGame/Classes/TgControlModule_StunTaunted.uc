class TgControlModule_StunTaunted extends TgControlModule_ThirdPerson;

var float m_fInitialYaw;
var const float m_fInterpTime;
var float m_fRemainingInterpTime;

function OnBecomeActive(TgControlModule OldModule)
{
    local Vector Loc;
    local Rotator Rot;

    super.OnBecomeActive(OldModule);
    Controller.GetPlayerViewPoint(Loc, Rot);
    m_fInitialYaw = float(Rot.Yaw);
    m_fRemainingInterpTime = m_fInterpTime;
    //return;    
}

function OnBecomeInActive(TgControlModule NewModule)
{
    super(TgControlModule).OnBecomeInActive(NewModule);
    // End:0x85
    if(Controller != none)
    {
        // End:0x66
        if(Controller.bPressingLeftMouseButton)
        {
            Controller.OnLeftMousePressed();            
        }
        else
        {
            Controller.OnLeftMouseReleased();
        }
    }
    //return;    
}

function Vector CalcNewAccel()
{
    local Vector newAccel, PawnToTarget;
    local TgPawn TgP;
    local float PawnCollisionRadius;
    local Rotator InitialRotation, NewRotation;

    TgP = TgPawn(Controller.Pawn);
    // End:0x1F6
    if((TgP != none) && TgP.r_StunTauntTarget != none)
    {
        PawnToTarget = TgP.r_StunTauntTarget.Location - TgP.Location;
        PawnCollisionRadius = TgP.GetCollisionRadius() + 5.0000000;
        // End:0x1F6
        if(VSizeSq2D(PawnToTarget) > (PawnCollisionRadius * PawnCollisionRadius))
        {
            InitialRotation = Rotator(PawnToTarget);
            InitialRotation.Yaw = int(m_fInitialYaw);
            NewRotation = Rotator(PawnToTarget);
            NewRotation = RLerp(NewRotation, InitialRotation, m_fRemainingInterpTime / m_fInterpTime, true);
            newAccel = Vector(NewRotation) * Controller.Pawn.AccelRate;
        }
    }
    return newAccel;
    //return ReturnValue;    
}

function UpdateRotation(float DeltaTime)
{
    local Vector newAccel;
    local Rotator NewRotation;
    local bool bFixedPitchMode;
    local TgPawn TgP;

    // End:0x11
    if(Controller == none)
    {
        return;
    }
    TgP = TgPawn(Controller.Pawn);
    bFixedPitchMode = IsFixedPitchMode();
    NewRotation = Controller.Rotation;
    // End:0xE3
    if(!bFixedPitchMode)
    {
        NewRotation.Pitch = int(Controller.PlayerInput.aLookUp);        
    }
    else
    {
        // End:0x189
        if(TgP != none)
        {
            NewRotation.Pitch = int(EvalInterpCurveFloat(PitchCurve, fAimPitch));
            NewRotation.Pitch = int(TgP.ApplyPitchLimit(float(NewRotation.Pitch)));
        }
    }
    newAccel = CalcNewAccel();
    NewRotation.Yaw = Rotator(newAccel).Yaw;
    Controller.SetRotation(NewRotation);
    // End:0x2A4
    if(Controller.Pawn != none)
    {
        Controller.Pawn.SetDesiredRotation(NewRotation);
        Controller.Pawn.FaceRotation(NewRotation, DeltaTime);
    }
    // End:0x2DC
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