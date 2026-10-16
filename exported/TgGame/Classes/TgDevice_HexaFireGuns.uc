class TgDevice_HexaFireGuns extends TgDevice_QuadWield
    hidecategories(Navigation);

var TgPawn_Ruckus m_CachedRuckusOwner;

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    // End:0x42
    if((IsFiring()) || (HasCachedRuckusOwner()) && m_CachedRuckusOwner.r_bHexaFireFiring)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController)
{
    // End:0x42
    if((IsFiring()) || (HasCachedRuckusOwner()) && m_CachedRuckusOwner.r_bHexaFireFiring)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptRightMousePressed(TgPlayerController TgController)
{
    // End:0x42
    if((IsFiring()) || (HasCachedRuckusOwner()) && m_CachedRuckusOwner.r_bHexaFireFiring)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptRightMouseReleased(TgPlayerController TgController)
{
    // End:0x42
    if((IsFiring()) || (HasCachedRuckusOwner()) && m_CachedRuckusOwner.r_bHexaFireFiring)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool HasCachedRuckusOwner()
{
    // End:0x2B
    if(m_CachedRuckusOwner == none)
    {
        m_CachedRuckusOwner = TgPawn_Ruckus(Owner);
    }
    return m_CachedRuckusOwner != none;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3B
    if((Current != none) && Current.r_nDeviceId == 11434)
    {
        return false;
    }
    return super(TgDevice).ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn_Ruckus Ruckus;

        Ruckus = TgPawn_Ruckus(Instigator);
        // End:0xAA
        if(Ruckus != none)
        {
            // End:0xAA
            if(Ruckus.m_WeaponMesh != none)
            {
                Ruckus.m_WeaponMesh.SetFireLoopDisplayGroup('HexaFire', Class'TgGame.TgSkeletalMeshComponent_Weapon'.default.m_nmFireLoopTailSound);
            }
        }
        super.StartFiringLogic();
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Ruckus Ruckus;

        Ruckus = TgPawn_Ruckus(Instigator);
        // End:0x83
        if(Ruckus != none)
        {
            // End:0x83
            if(Ruckus.m_WeaponMesh != none)
            {
                Ruckus.m_WeaponMesh.ResetFireLoopDisplayGroup();
            }
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_vProjectileSpawnOffset3=(X=5.0000000,Y=2.0000000,Z=11.0000000)
    m_vProjectileSpawnOffset4=(X=5.0000000,Y=-2.0000000,Z=11.0000000)
    m_nWeaponFireNumber=1
    m_vProjectileSpawnOffset2=(X=5.0000000,Y=-6.0000000,Z=5.0000000)
    m_vProjectileSpawnOffset=(X=5.0000000,Y=6.0000000,Z=5.0000000)
}