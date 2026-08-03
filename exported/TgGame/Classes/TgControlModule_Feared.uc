class TgControlModule_Feared extends TgControlModule_ThirdPerson;

var float c_fLastSwitchTime;
var float c_fNextSwitchTime;
var Vector c_vCurrentDirection;

function OnBecomeActive(TgControlModule OldModule)
{
    super.OnBecomeActive(OldModule);
    // End:0x7E
    if(int(Controller.m_eCurrentStunType) == int(9))
    {
        c_vCurrentDirection = Vector(Controller.Pawn.Rotation);        
    }
    else
    {
        ChangeDirections();
    }
    //return;    
}

function Vector CalcNewAccel()
{
    local Vector newAccel;

    // End:0x74
    if(c_fNextSwitchTime < Controller.WorldInfo.TimeSeconds)
    {
        // End:0x74
        if(int(Controller.m_eCurrentStunType) != int(9))
        {
            ChangeDirections();
        }
    }
    newAccel = Controller.Pawn.AccelRate * Normal(c_vCurrentDirection);
    return newAccel;
    //return ReturnValue;    
}

function ChangeDirections()
{
    local float fAngle;
    local Rotator Rot;

    Rot = Controller.Rotation;
    fAngle = (0.5000000 - FRand()) * float(16384);
    Rot.Yaw += int(fAngle);
    c_vCurrentDirection = Vector(Rot);
    c_fLastSwitchTime = Controller.WorldInfo.TimeSeconds;
    c_fNextSwitchTime = (Controller.WorldInfo.TimeSeconds + float(1)) + (FRand() * 0.5000000);
    //return;    
}

function UpdateRotation(float DeltaTime)
{
    local Vector newAccel;
    local Rotator NewRotation;
    local float fAlpha;

    // End:0x11
    if(Controller == none)
    {
        return;
    }
    newAccel = Controller.Pawn.AccelRate * Normal(c_vCurrentDirection);
    // End:0x195
    if(VSize(newAccel) > float(0))
    {
        NewRotation = Rotator(newAccel);
        NewRotation.Pitch = Controller.Rotation.Pitch;
        fAlpha = FClamp((Controller.WorldInfo.TimeSeconds - c_fLastSwitchTime) / 0.3000000, 0.0000000, 1.0000000);
        NewRotation = RLerp(Controller.Rotation, NewRotation, fAlpha);
        Controller.SetRotation(NewRotation);        
    }
    else
    {
        NewRotation = Controller.Rotation;
    }
    // End:0x268
    if(Controller.Pawn != none)
    {
        Controller.Pawn.SetDesiredRotation(NewRotation);
        Controller.Pawn.FaceRotation(NewRotation, DeltaTime);
    }
    //return;    
}

defaultproperties
{
    c_fNextSwitchTime=-1.0000000
}