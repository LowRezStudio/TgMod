class TgDevice_Rewind extends TgDevice
    hidecategories(Navigation);

var TgDevice_Illusion m_CachedIllusionDevice;

function DoRewindCardLogic(TgDevice_DimensionalLink dimensionalLinkDevice)
{
    local int I;
    local TgPawn newIllusion;
    local TgPawn_Illusion newIllusionDecoyPawn;
    local TgDeviceFire FireMode;

    // End:0x41C
    if(((int(Role) == int(ROLE_Authority)) && IsActive()) && m_CachedIllusionDevice != none)
    {
        // End:0x41C
        if((dimensionalLinkDevice.m_CachedAim.HitActor != none) && dimensionalLinkDevice.m_CachedAim.HitActor.IsA('TgDeployable'))
        {
            newIllusion = m_CachedIllusionDevice.SpawnIllusionAtLocation(dimensionalLinkDevice.m_CachedAim.HitActor.Location, dimensionalLinkDevice.m_CachedAim.HitActor.Rotation);
            // End:0x41C
            if(newIllusion != none)
            {
                I = 0;
                J0x189:

                // End:0x256 [Loop If]
                if(I < dimensionalLinkDevice.s_nNumCycleTargets)
                {
                    // End:0x248
                    if(dimensionalLinkDevice.s_CycleTargets[I] == dimensionalLinkDevice.m_CachedAim.HitActor)
                    {
                        dimensionalLinkDevice.s_CycleTargets[I] = newIllusion;
                        // [Explicit Break]
                        goto J0x256;
                    }
                    I++;
                    // [Loop Continue]
                    goto J0x189;
                }
                J0x256:

                dimensionalLinkDevice.m_CachedAim.HitActor.Destroy();
                dimensionalLinkDevice.m_CachedAim.HitActor = newIllusion;
                FireMode = GetCurrentFire();
                // End:0x355
                if(FireMode != none)
                {
                    newIllusion.SetHealth(int(newIllusion.GetMaxHealth() * FireMode.GetCustomValue1()));
                }
                newIllusionDecoyPawn = TgPawn_Illusion(newIllusion);
                // End:0x41C
                if((newIllusionDecoyPawn != none) && newIllusionDecoyPawn.s_OnDeathDelegates.Find(dimensionalLinkDevice.IllusionDied) == -1)
                {
                    newIllusionDecoyPawn.s_OnDeathDelegates.AddItem(dimensionalLinkDevice.IllusionDied);
                }
            }
        }
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x73
        case 10335:
            m_CachedIllusionDevice = TgDevice_Illusion(Dev);
            // End:0x76
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=10335
}