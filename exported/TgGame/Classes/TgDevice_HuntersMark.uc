class TgDevice_HuntersMark extends TgDevice
    native(ChampTyra)
    hidecategories(Navigation);

// Export UTgDevice_HuntersMark::execGetConePullbackDistance(FFrame&, void* const)
native function float GetConePullbackDistance();

// Export UTgDevice_HuntersMark::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_HuntersMark::execValidateReceivedAim(FFrame&, void* const)
native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);

simulated function ImpactInfo CalcWeaponFire(AimData Aim, optional out array<ImpactInfo> ImpactList)
{
    local ImpactInfo Impact;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x1E6
    if((FireMode != none) && Aim.bResult == true)
    {
        Impact.bDirectHit = true;
        Impact.DeviceModeReference = FireMode;
        Impact.StartTrace = Aim.StartTrace;
        Impact.HitActor = Aim.HitActor;
        Impact.HitLocation = Aim.EndTrace;
        Impact.RayDir = Normal(Impact.HitLocation - Aim.StartTrace);
        Impact.HitNormal = -Impact.RayDir;
        ImpactList.AddItem(Impact);        
    }
    else
    {
        Impact.HitActor = none;
    }
    return Impact;
    //return ReturnValue;    
}
