class TgDevice_AimDownSights extends TgDevice
    hidecategories(Navigation);

var repnotify bool r_bIsADS;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bIsADS;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x35
    if((VarName == 'r_bIsADS') && r_bIsADS == false)
    {
        EndADS();
        return;
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldCancelStealth()
{
    return false;
    //return ReturnValue;    
}

simulated function EndADS()
{
    local TgDevice theWeapon;

    theWeapon = TgDevice(Instigator.Weapon);
    // End:0x60
    if(theWeapon != none)
    {
        theWeapon.AltUse(false);
    }
    //return;    
}

reliable server event InterruptFiring()
{
    r_bIsADS = false;
    EndADS();
    super.InterruptFiring();
    //return;    
}

simulated function StopFire()
{
    r_bIsADS = false;
    EndADS();
    super.StopFire();
    //return;    
}

reliable server function ServerStartFire(optional float MovementTimeStamp, optional Vector MovementInAccel, optional Vector MovementClientLoc, optional byte MovementNewFlags, optional byte MovementClientRoll, optional int MovementView, optional int ClientFireRequestId = -1, optional byte ClientFireMode = 255, optional Actor HitActor = none, optional float StartTraceX = -10000000.0000000, optional float StartTraceY = -10000000.0000000, optional float StartTraceZ = -10000000.0000000, optional float EndTraceX = -10000000.0000000, optional float EndTraceY = -10000000.0000000, optional float EndTraceZ = -10000000.0000000, optional int nCompressedAimVector = -1, optional bool bFirstBurstShot = false)
{
    r_bIsADS = true;
    super.ServerStartFire(MovementTimeStamp, MovementInAccel, MovementClientLoc, MovementNewFlags, MovementClientRoll, MovementView, ClientFireRequestId, ClientFireMode, HitActor, StartTraceX, StartTraceY, StartTraceZ, EndTraceX, EndTraceY, EndTraceZ, nCompressedAimVector, bFirstBurstShot);
    //return;    
}
