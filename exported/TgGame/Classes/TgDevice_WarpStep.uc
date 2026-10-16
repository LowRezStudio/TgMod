class TgDevice_WarpStep extends TgDevice
    hidecategories(Navigation);

var bool m_bRolledBackward;

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated function bool IsUltActive()
{
    local TgPawn_Demon PawnOwner;

    PawnOwner = TgPawn_Demon(Owner);
    // End:0x4B
    if(PawnOwner != none)
    {
        return PawnOwner.r_bIsUltActive;
    }
    return false;
    //return ReturnValue;    
}

simulated function UpdateDesiredFireMode()
{
    m_nDesiredFireMode = ((IsUltActive()) ? 1 : 0);
    //return;    
}

simulated function Rotator GetChargeDirection()
{
    // End:0x96
    if((Instigator.Acceleration.X == float(0)) && Instigator.Acceleration.Y == float(0))
    {
        return Instigator.Rotation;        
    }
    else
    {
        return Rotator(Normal2D(Instigator.Acceleration));
    }
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    local TgDeviceFire FireMode;
    local TgPawn_Demon PawnOwner;
    local float fRange;
    local TeleportParams TelParams;

    super.FireAmmunition();
    FireMode = GetCurrentFire();
    PawnOwner = TgPawn_Demon(Owner);
    // End:0x32A
    if((PawnOwner != none) && FireMode != none)
    {
        fRange = FireMode.GetRange();
        TelParams.vTargetLocation = PawnOwner.Location + (Vector(GetChargeDirection()) * fRange);
        TelParams.rTargetRotation = PawnOwner.Rotation;
        TelParams.bPlayFx = true;
        TelParams.bDoBackTrace = true;
        TelParams.vBackTraceDir = -Vector(GetChargeDirection());
        TelParams.fBackTraceIncrement = PawnOwner.GetCollisionRadius();
        TelParams.fBackTraceMaxDist = fRange * 0.5000000;
        TelParams.bLookForGround = true;
        TelParams.fGroundSearchHeight = FireMode.GetCustomValue1() * float(16);
        TelParams.fGroundSearchRayRadius = PawnOwner.GetCollisionRadius();
        TelParams.bCheckLineOfSight = true;
        TelParams.fMovementCorrectionDisableTime = 0.3000000;
        // End:0x32A
        if(PawnOwner.AdvancedTeleport(TelParams))
        {
            PawnOwner.Velocity = vect(0.0000000, 0.0000000, 0.0000000);
            StartCooldown();            
        }
    }
    //return;    
}

defaultproperties
{
    m_IndividualOffhandCooldownTime=0.3000000
}