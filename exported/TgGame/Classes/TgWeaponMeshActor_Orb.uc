class TgWeaponMeshActor_Orb extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var() float m_fFireGlowFadeTime;
var float m_fRemainingGlowFadeTime;

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode)
{
    local MaterialInstanceConstant MIC;
    local int I;

    super.PlayFireEffects(nEquipSlot, fRefireTime, nFireMode);
    // End:0x111
    if((nEquipSlot == 1) && m_WeaponMesh1P != none)
    {
        m_fRemainingGlowFadeTime = 0.0000000;
        I = 0;
        J0x5F:

        // End:0x111 [Loop If]
        if(I < m_WeaponMesh1P.GetNumElements())
        {
            MIC = MaterialInstanceConstant(m_WeaponMesh1P.GetMaterial(I));
            // End:0x103
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('ActiveGlow', 1.0000000);
            }
            I++;
            // [Loop Continue]
            goto J0x5F;
        }
    }
    //return;    
}

simulated function StopFireEffects(int nEquipSlot)
{
    super.StopFireEffects(nEquipSlot);
    m_fRemainingGlowFadeTime = m_fFireGlowFadeTime;
    //return;    
}

simulated function Tick(float DeltaTime)
{
    local MaterialInstanceConstant MIC;
    local int I;

    super.Tick(DeltaTime);
    // End:0x131
    if(m_fRemainingGlowFadeTime > float(0))
    {
        m_fRemainingGlowFadeTime = FMax(m_fRemainingGlowFadeTime - DeltaTime, 0.0000000);
        // End:0x131
        if(m_WeaponMesh1P != none)
        {
            I = 0;
            J0x63:

            // End:0x131 [Loop If]
            if(I < m_WeaponMesh1P.GetNumElements())
            {
                MIC = MaterialInstanceConstant(m_WeaponMesh1P.GetMaterial(I));
                // End:0x123
                if(MIC != none)
                {
                    MIC.SetScalarParameterValue('ActiveGlow', FPctByRange(m_fRemainingGlowFadeTime, 0.0000000, m_fFireGlowFadeTime));
                }
                I++;
                // [Loop Continue]
                goto J0x63;
            }
        }
    }
    //return;    
}

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot)
{
    local TgPawn_Grohk TgP;

    TgP = TgPawn_Grohk(Owner);
    // End:0xBA
    if((TgP != none) && TgP.r_InhandTarget != none)
    {
        HitLocation = TgP.r_InhandTarget.Location;
        HitLocation += TgP.r_InhandHitOffset;
        return true;
    }
    return super.GetSimulatedBeamTarget(HitLocation, nEquipSlot);
    //return ReturnValue;    
}

defaultproperties
{
    m_fFireGlowFadeTime=1.5000000
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_Orb.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}