class TgWeaponMeshActor_GauntletInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var TgSpecialFx m_HyperBeamFX;
var Actor m_LastInhandTarget;

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate = false)
{
    super.UpdateTransform(DeltaTime, bFromCameraUpdate);
    UpdateBeamEffects(16);
    //return;    
}

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot)
{
    local TgPawn_Gauntlet TgP;

    TgP = TgPawn_Gauntlet(Owner);
    // End:0x181
    if(TgP != none)
    {
        // End:0xE0
        if((nEquipSlot == 1) || nEquipSlot == 0)
        {
            // End:0xDB
            if(TgP.r_InhandTarget != none)
            {
                HitLocation = TgP.r_InhandTarget.Location;
                HitLocation += TgP.c_InterpInhandHitOffset;
                return true;                
            }
            else
            {
                return false;
            }            
        }
        else
        {
            // End:0x181
            if(nEquipSlot == 16)
            {
                // End:0x17F
                if(TgP.r_RechargeTarget != none)
                {
                    HitLocation = TgP.r_RechargeTarget.Location;
                    HitLocation += TgP.c_InterpRechargeHitOffset;
                    return true;                    
                }
                else
                {
                    return false;
                }
            }
        }
    }
    return super.GetSimulatedBeamTarget(HitLocation, nEquipSlot);
    //return ReturnValue;    
}

simulated function bool GetAccurateBeamTarget(out Vector HitLocation, int nEquipSlot)
{
    local TgPawn_Gauntlet TgP;

    TgP = TgPawn_Gauntlet(Owner);
    // End:0x180
    if(TgP != none)
    {
        // End:0xDF
        if((nEquipSlot == 1) || nEquipSlot == 0)
        {
            // End:0xDA
            if(TgP.r_InhandTarget != none)
            {
                HitLocation = TgP.r_InhandTarget.Location;
                HitLocation += TgP.c_InterpInhandHitOffset;
                return true;                
            }
            else
            {
                return false;
            }            
        }
        else
        {
            // End:0x180
            if(nEquipSlot == 16)
            {
                // End:0x17E
                if(TgP.r_RechargeTarget != none)
                {
                    HitLocation = TgP.r_RechargeTarget.Location;
                    HitLocation += TgP.c_InterpRechargeHitOffset;
                    return true;                    
                }
                else
                {
                    return false;
                }
            }
        }
    }
    return super.GetAccurateBeamTarget(HitLocation, nEquipSlot);
    //return ReturnValue;    
}

simulated function PlayFireFx(int nEquipSlot, int nFireMode)
{
    local TgPawn_Gauntlet TgP;

    // End:0x78
    if(nEquipSlot == 16)
    {
        TgP = TgPawn_Gauntlet(Owner);
        // End:0x75
        if(TgP != none)
        {
            // End:0x75
            if(TgP.r_RechargeTarget != none)
            {
                super.PlayFireFx(nEquipSlot, 1);
                return;
            }
        }        
    }
    else
    {
        // End:0x18B
        if(nEquipSlot == 1)
        {
            TgP = TgPawn_Gauntlet(Owner);
            // End:0x18B
            if(TgP != none)
            {
                // End:0xFA
                if(TgP.r_InhandTarget == none)
                {
                    SetLoopingMuzzleEffects(false, nEquipSlot);
                    ActivateFireLoopFailed(true);
                    return;                    
                }
                else
                {
                    // End:0x13A
                    if(TgP.r_InhandTarget != m_LastInhandTarget)
                    {
                        SetLoopingMuzzleEffects(false, nEquipSlot);
                    }
                    m_LastInhandTarget = TgP.r_InhandTarget;
                    ActivateFireLoopFailed(false);
                    super.PlayFireFx(nEquipSlot, nFireMode);
                    return;
                }
            }
        }
    }
    super.PlayFireFx(nEquipSlot, nFireMode);
    //return;    
}

simulated function StopFireEffects(int nEquipSlot)
{
    super.StopFireEffects(nEquipSlot);
    ActivateFireLoopFailed(false);
    //return;    
}

simulated function ActivateFireLoopFailed(bool bIsActive)
{
    // End:0x88
    if(bIsActive)
    {
        // End:0x49
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.FxActivateGroup('FireLoopFailed', 0);
        }
        // End:0x85
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.FxActivateGroup('FireLoopFailed', 0);
        }        
    }
    else
    {
        // End:0xC2
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.FxDeactivateGroup('FireLoopFailed', 0);
        }
        // End:0xFC
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.FxDeactivateGroup('FireLoopFailed', 0);
        }
    }
    //return;    
}

simulated function UpdateFireLoopBeamParams(bool bHasEndPoint, Vector HitLocation, optional int nEquipSlot = 1)
{
    // End:0x2B
    if(!bHasEndPoint)
    {
        SetLoopingMuzzleEffects(false, nEquipSlot);        
    }
    else
    {
        super.UpdateFireLoopBeamParams(bHasEndPoint, HitLocation, nEquipSlot);
        SetBeamTangent(HitLocation);
    }
    //return;    
}

simulated function SetBeamTangent(Vector HitLocation, optional int nEquipSlot = 1)
{
    local Vector fireLoc, Tangent;
    local Rotator FireRot;
    local int I;
    local editinline array<editinline ParticleSystemComponent> FireLoopParticles;
    local editinline ParticleSystemComponent Particle;

    GetFiringSocketTransform(fireLoc, FireRot);
    Tangent = (HitLocation - fireLoc) / float(25);
    GetAllFireLoopParticleSystemComponents(FireLoopParticles, nEquipSlot);
    // End:0x12B
    foreach FireLoopParticles(Particle)
    {
        I = 0;
        J0x83:

        // End:0x12A [Loop If]
        if(I < Particle.EmitterInstances.Length)
        {
            Particle.SetBeamTargetTangent(I, Tangent, 0);
            Particle.SetBeamSourceTangent(I, Vector(FireRot) * float(10), 0);
            I++;
            // [Loop Continue]
            goto J0x83;
        }        
    }    
    //return;    
}

defaultproperties
{
    m_PlayFireEffectsOn[1]=TG_PLAY_FIRE_EFFECT_ON.Fire
    m_PlayFireEffectsOn[2]=TG_PLAY_FIRE_EFFECT_ON.Fire
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_GauntletInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}