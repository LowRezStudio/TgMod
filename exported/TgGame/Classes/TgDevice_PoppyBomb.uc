class TgDevice_PoppyBomb extends TgDevice
    native(ChampBombKing)
    hidecategories(Navigation);

var bool r_bHasActiveProjectile;

replication
{
    // Pos:0x000
    if(((int(Role) == int(ROLE_Authority)) && bNetDirty) && !bNetInitial)
        r_bHasActiveProjectile;
}

// Export UTgDevice_PoppyBomb::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function UpdateActiveProjectiles(optional TgProjectile Proj)
{
    local int I;

    m_FiredProjectiles.AddItem(Proj);
    I = 0;
    J0x22:

    // End:0x102 [Loop If]
    if(I < m_FiredProjectiles.Length)
    {
        // End:0xF4
        if((((m_FiredProjectiles[I] == none) || m_FiredProjectiles[I].m_bHasExploded) || m_FiredProjectiles[I].bDeleteMe) || m_FiredProjectiles[I].m_bIsShutDown)
        {
            m_FiredProjectiles.Remove(I--, 1);
        }
        I++;
        // [Loop Continue]
        goto J0x22;
    }
    // End:0x13C
    if(m_FiredProjectiles.Length > 0)
    {
        // End:0x139
        if(!r_bHasActiveProjectile)
        {
            r_bHasActiveProjectile = true;
            bNetDirty = true;
        }        
    }
    else
    {
        // End:0x161
        if(r_bHasActiveProjectile)
        {
            r_bHasActiveProjectile = false;
            bNetDirty = true;
        }
    }
    //return;    
}

simulated event bool ShouldCooldownAfterFire()
{
    // End:0x16
    if(int(CurrentFireMode) == int(1))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool HasActivePoppyBomb()
{
    local TgPawn TgP;
    local TgRepInfo_Player PRI;
    local int I;
    local TgDeployable deployable;

    // End:0x2B
    if((m_FiredProjectiles.Length > 0) || IsTimerActive('SpawnQueuedSimulatedProjectile'))
    {
        return true;
    }
    TgP = TgPawn(Owner);
    // End:0x164
    if(TgP != none)
    {
        PRI = TgP.GetPRI();
        // End:0x164
        if(PRI != none)
        {
            I = 0;
            J0x99:

            // End:0x164 [Loop If]
            if(I < PRI.m_DRIArray.Length)
            {
                deployable = PRI.m_DRIArray[I].r_DeployableOwner;
                // End:0x156
                if(deployable.IsA('TgDeploy_PoppyBomb'))
                {
                    // End:0x156
                    if(!deployable.m_bInDestroyedState)
                    {
                        return true;
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x99;
            }
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function DetonatePoppyBomb()
{
    local TgPawn TgP;
    local TgRepInfo_Player PRI;
    local int I;
    local TgDeploy_PoppyBomb PoppyBombDeployable;

    // End:0x1E
    if(int(Role) < int(ROLE_Authority))
    {
        ServerDetonatePoppyBomb();
    }
    I = m_FiredProjectiles.Length - 1;
    J0x35:

    // End:0x94 [Loop If]
    if(I >= 0)
    {
        // End:0x86
        if(m_FiredProjectiles[I] != none)
        {
            m_FiredProjectiles[I].AltFireDetonate();
        }
        I--;
        // [Loop Continue]
        goto J0x35;
    }
    UpdateActiveProjectiles();
    TgP = TgPawn(Owner);
    // End:0x24C
    if(TgP != none)
    {
        PRI = TgP.GetPRI();
        // End:0x24C
        if(PRI != none)
        {
            I = 0;
            J0x10D:

            // End:0x24C [Loop If]
            if(I < PRI.m_DRIArray.Length)
            {
                PoppyBombDeployable = TgDeploy_PoppyBomb(PRI.m_DRIArray[I].r_DeployableOwner);
                // End:0x23E
                if(PoppyBombDeployable != none)
                {
                    // End:0x23E
                    if(!PoppyBombDeployable.m_bInDestroyedState)
                    {
                        PoppyBombDeployable.InstantFireDeployable();
                        PoppyBombDeployable.r_bDetonated = true;
                        PoppyBombDeployable.bNetDirty = true;
                        PoppyBombDeployable.DestroyIt();
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x10D;
            }
        }
    }
    PlayPoppyDetonateAnim();
    StartCooldown();
    //return;    
}

reliable server function ServerDetonatePoppyBomb()
{
    DetonatePoppyBomb();
    //return;    
}

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    local TgPawn_BombKing BombKing;
    local TgWeaponMeshActor_BombKingInhand BKWeaponMeshActor;

    BombKing = TgPawn_BombKing(Owner);
    // End:0x8C
    if(BombKing != none)
    {
        BKWeaponMeshActor = TgWeaponMeshActor_BombKingInhand(BombKing.m_WeaponMesh);
        // End:0x8C
        if(BKWeaponMeshActor != none)
        {
            BKWeaponMeshActor.m_bPlayPoppyDetonateAnimation = false;
        }
    }
    super.HandleDeviceFormStartFire(nDeviceModeNum, fRefireTime, Aim);
    //return;    
}

simulated function PlayPoppyDetonateAnim()
{
    local TgPawn_BombKing BombKing;
    local TgWeaponMeshActor_BombKingInhand BKWeaponMeshActor;
    local AimData Aim;

    BombKing = TgPawn_BombKing(Owner);
    // End:0x8C
    if(BombKing != none)
    {
        BKWeaponMeshActor = TgWeaponMeshActor_BombKingInhand(BombKing.m_WeaponMesh);
        // End:0x8C
        if(BKWeaponMeshActor != none)
        {
            BKWeaponMeshActor.m_bPlayPoppyDetonateAnimation = true;
        }
    }
    GetCachedAim(Aim);
    HandleDeviceFormStartFire(int(CurrentFireMode), GetRefireTime(), Aim);
    //return;    
}

simulated event bool Use()
{
    // End:0x5C
    if(((HasActivePoppyBomb()) && !IsTimerActive('FirePostHitDelay')) && !IsTimerActive('FirePreHitDelay'))
    {
        PlayPoppyDetonateAnim();
        DetonatePoppyBomb();
        return true;        
    }
    else
    {
        return super.Use();
    }
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function FirePostHitDelay()
    {
        local TgDeviceFire deviceFire;
        local TgPawn TgP;
        local TgPlayerController TgPC;

        super.FirePostHitDelay();
        // End:0xDB
        if(HasActivePoppyBomb())
        {
            deviceFire = GetCurrentFire();
            // End:0xDB
            if(deviceFire != none)
            {
                TgP = TgPawn(Instigator);
                // End:0xDB
                if(TgP != none)
                {
                    TgPC = TgPlayerController(TgP.Controller);
                    // End:0xDB
                    if(TgPC != none)
                    {
                        // End:0xDB
                        if(TgPC.bPressingMovementButton)
                        {
                            PlayPoppyDetonateAnim();
                            DetonatePoppyBomb();
                        }
                    }
                }
            }
        }
        //return;        
    }
    stop;    
}
