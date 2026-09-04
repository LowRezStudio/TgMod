class TgWeaponMeshActor_OracleInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

const MAX_BEAM_SEGMENTS = 12;
const BEAM_FADE_START_DIST = 800.0f;
const BEAM_FADE_END_DIST = 3000.0f;
const BEAM_FADE_START_VALUE = 0.0f;
const BEAM_FADE_END_VALUE = 0.7f;

var Actor m_LastRestoreSoulTarget;

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate = false)
{
    super.UpdateTransform(DeltaTime, bFromCameraUpdate);
    UpdateBeamEffects(16);
    //return;    
}

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot)
{
    local TgPawn_Oracle TgP;

    TgP = TgPawn_Oracle(Owner);
    // End:0xCD
    if(TgP != none)
    {
        // End:0xCD
        if(nEquipSlot == 16)
        {
            // End:0xCB
            if(TgP.r_RestoreSoulTarget != none)
            {
                HitLocation = TgP.r_RestoreSoulTarget.Location;
                HitLocation += TgP.r_RestoreSoulHitOffset;
                return true;                
            }
            else
            {
                return false;
            }
        }
    }
    return super.GetSimulatedBeamTarget(HitLocation, nEquipSlot);
    //return ReturnValue;    
}

simulated function bool GetAccurateBeamTarget(out Vector HitLocation, int nEquipSlot)
{
    local TgPawn_Oracle TgP;

    TgP = TgPawn_Oracle(Owner);
    // End:0xCC
    if(TgP != none)
    {
        // End:0xCC
        if(nEquipSlot == 16)
        {
            // End:0xCA
            if(TgP.r_RestoreSoulTarget != none)
            {
                HitLocation = TgP.r_RestoreSoulTarget.Location;
                HitLocation += TgP.r_RestoreSoulHitOffset;
                return true;                
            }
            else
            {
                return false;
            }
        }
    }
    return super.GetAccurateBeamTarget(HitLocation, nEquipSlot);
    //return ReturnValue;    
}

simulated function PlayFireFx(int nEquipSlot, int nFireMode)
{
    local TgPawn_Oracle TgP;

    // End:0x114
    if(nEquipSlot == 16)
    {
        TgP = TgPawn_Oracle(Owner);
        // End:0x114
        if(TgP != none)
        {
            // End:0x83
            if(TgP.r_RestoreSoulTarget == none)
            {
                SetLoopingMuzzleEffects(false, nEquipSlot);
                ActivateFireLoopFailed(true);
                return;                
            }
            else
            {
                // End:0xC3
                if(TgP.r_RestoreSoulTarget != m_LastRestoreSoulTarget)
                {
                    SetLoopingMuzzleEffects(false, nEquipSlot);
                }
                m_LastRestoreSoulTarget = TgP.r_RestoreSoulTarget;
                ActivateFireLoopFailed(false);
                super.PlayFireFx(nEquipSlot, nFireMode);
                return;
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
    super.UpdateFireLoopBeamParams(bHasEndPoint, HitLocation, nEquipSlot);
    // End:0x54
    if(bHasEndPoint)
    {
        SetBeamTangent(HitLocation, nEquipSlot);
    }
    //return;    
}

simulated function SetBeamTangent(Vector HitLocation, optional int nEquipSlot = 1)
{
    local Vector fireLoc, TargetDir, Target, Source;
    local Quat targetQuat, SourceQuat;
    local Rotator FireRot;
    local float DistanceToTarget, AngleToTarget, AnglePerc;
    local int I, J;
    local editinline array<editinline ParticleSystemComponent> FireLoopParticles;
    local editinline ParticleSystemComponent Particle;
    local float Perc1, Perc2, DistMult1, DistMult2, SegmentDist, FadePerc;

    GetFiringSocketTransform(fireLoc, FireRot);
    TargetDir = HitLocation - fireLoc;
    DistanceToTarget = VSize(TargetDir);
    TargetDir = TargetDir / DistanceToTarget;
    Target = TargetDir;
    Source = Vector(FireRot);
    AngleToTarget = RDiff(FireRot, Rotator(Target));
    AnglePerc = AngleToTarget / 180.0000000;
    // End:0x10B
    if(IsFirstPerson())
    {
        SegmentDist = Lerp(5.0000000, 75.0000000, AnglePerc);        
    }
    else
    {
        SegmentDist = Lerp(1.0000000, 35.0000000, AnglePerc * AnglePerc);
    }
    targetQuat = QuatFromRotator(Rotator(Target));
    SourceQuat = QuatFromRotator(Rotator(Source));
    GetAllFireLoopParticleSystemComponents(FireLoopParticles, nEquipSlot);
    // End:0x458
    foreach FireLoopParticles(Particle)
    {
        I = 0;
        J0x1B1:

        // End:0x3A8 [Loop If]
        if(I < Particle.EmitterInstances.Length)
        {
            J = 0;
            J0x1E9:

            // End:0x39A [Loop If]
            if(J < 12)
            {
                Perc1 = float(J) / float(12 + 1);
                Perc2 = float(J + 1) / float(12 + 1);
                DistMult1 = Lerp(float(Min(int(SegmentDist), int(DistanceToTarget * 0.3300000))), 1.0000000, Perc1);
                DistMult2 = Lerp(float(Min(int(SegmentDist), int(DistanceToTarget * 0.3300000))), 1.0000000, Perc2);
                Particle.SetBeamSourceTangent(I, Vector(QuatToRotator(QuatSlerp(SourceQuat, targetQuat, Perc1))) * DistMult1, J);
                Particle.SetBeamTargetTangent(I, -Vector(QuatToRotator(QuatSlerp(SourceQuat, targetQuat, Perc2))) * DistMult2, J);
                J++;
                // [Loop Continue]
                goto J0x1E9;
            }
            I++;
            // [Loop Continue]
            goto J0x1B1;
        }
        // End:0x3CD
        if(DistanceToTarget <= 800.0000000)
        {
            FadePerc = 0.0000000;            
        }
        else
        {
            // End:0x3F2
            if(DistanceToTarget >= 3000.0000000)
            {
                FadePerc = 1.0000000;                
            }
            else
            {
                FadePerc = (DistanceToTarget - 800.0000000) / (3000.0000000 - 800.0000000);
            }
        }
        Particle.SetFloatParameter('DistanceFade', Lerp(0.0000000, 0.7000000, FadePerc));        
    }    
    //return;    
}

defaultproperties
{
    m_PlayFireEffectsOn[16]=TG_PLAY_FIRE_EFFECT_ON.Fire
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_OracleInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}