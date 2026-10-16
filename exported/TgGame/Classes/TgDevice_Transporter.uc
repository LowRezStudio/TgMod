class TgDevice_Transporter extends TgDevice
    native(ChampKinessa)
    hidecategories(Navigation);

var float m_fDowntraceDistance;
var Vector c_vCurrentTargeting2Location;

// Export UTgDevice_Transporter::execGetGroundTargetAim(FFrame&, void* const)
native function GetGroundTargetAim(out AimData Aim);

// Export UTgDevice_Transporter::execTickTargetingMode(FFrame&, void* const)
native function TickTargetingMode(float DeltaSeconds);

// Export UTgDevice_Transporter::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x18
    if(super.ShouldLockFiring(Current))
    {
        return true;
    }
    // End:0x54
    if((Current != none) && int(Current.r_eEquippedAt) == int(23))
    {
        return false;
    }
    return m_bInTargetingMode || IsFiring();
    //return ReturnValue;    
}

event OnDeployableDestroyed(TgDeployable deployable)
{
    // End:0x43
    if(deployable == r_Deployable)
    {
        r_Deployable = none;
        ClientPlayTransporterDestroyedSound();
        // End:0x43
        if(IsFiring())
        {
            InterruptFiring();
        }
    }
    //return;    
}

reliable client simulated function ClientPlayTransporterDestroyedSound()
{
    local TgPawn_Character TgPC;

    TgPC = TgPawn_Character(Owner);
    // End:0x7C
    if((TgPC != none) && TgPC.IsAliveAndWell())
    {
        TgPC.FxReactivateGroupSelf('KinessaTransporterDestroyed', 0);
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        local AimData Aim;
        local Rotator rSpawnRotation;
        local TgDeviceFire FireMode;
        local TgDeploy_Transporter transporter;
        local TgPawn_Kinessa Kinessa;
        local float fPreHitTime, fPostHitTime;

        super.BeginState(PreviousStateName);
        GetGroundTargetAim(Aim);
        // End:0x3B8
        if(Aim.bResult)
        {
            FireMode = GetCurrentFire();
            // End:0x3B8
            if(FireMode != none)
            {
                rSpawnRotation = Rotator(Aim.AimVector);
                rSpawnRotation.Pitch = 0;
                FireMode.DeployAtLocation(Aim.StartTrace + m_vProjectileSpawnOffset, rSpawnRotation);
                // End:0x204
                if(r_Deployable != none)
                {
                    transporter = TgDeploy_Transporter(r_Deployable);
                    // End:0x204
                    if(transporter != none)
                    {
                        transporter.r_TeleportLocation = Aim.EndTrace;
                        transporter.m_ProjectileEndLocation = transporter.r_TeleportLocation + ((vect(0.0000000, 0.0000000, 1.0000000) * transporter.m_fProjectileHeight) * float(16));
                        transporter.SpawnDeployFX();
                    }
                }
                Kinessa = TgPawn_Kinessa(Owner);
                // End:0x3B8
                if(Kinessa != none)
                {
                    fPreHitTime = FireMode.GetPreHitDelay();
                    Kinessa.r_fTeleportOverlayUpRate = ((fPreHitTime > 0.0000000) ? 1.0000000 / fPreHitTime : 10000.0000000);
                    fPostHitTime = FireMode.GetPostHitDelay();
                    Kinessa.r_fTeleportOverlayDownRate = ((fPostHitTime > 0.0000000) ? 1.0000000 / fPostHitTime : 10000.0000000);
                    Kinessa.r_bTeleportOverlayActive = true;
                    Kinessa.r_fTeleportOverlayMaxStrength = 1.0000000;
                    Kinessa.bNetDirty = true;
                    Kinessa.FlashTeleportFx(5, Kinessa.Location);
                }
            }
        }
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        local TgPawn_Kinessa Kinessa;

        super.FirePreHitDelay();
        Kinessa = TgPawn_Kinessa(Instigator);
        // End:0xCA
        if(Kinessa != none)
        {
            Kinessa.r_bTeleportOverlayActive = false;
            Kinessa.bNetDirty = true;
            // End:0xCA
            if(int(Role) == int(ROLE_Authority))
            {
                Kinessa.FlashTeleportFx(6, Kinessa.Location);
            }
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        local TgPawn_Kinessa Kinessa;

        Kinessa = TgPawn_Kinessa(Instigator);
        // End:0x6D
        if(Kinessa != none)
        {
            Kinessa.r_bTeleportOverlayActive = false;
            Kinessa.bNetDirty = true;
        }
        super.EndState(NextStateName);
        // End:0xAF
        if(r_Deployable != none)
        {
            r_Deployable.DestroyIt();
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fDowntraceDistance=4096.0000000
    c_bUsesTargetingReticle=false
    m_vProjectileSpawnOffset=(X=15.0000000,Y=1.0000000,Z=-9.0000000)
}