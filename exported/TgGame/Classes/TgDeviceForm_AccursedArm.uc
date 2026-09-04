class TgDeviceForm_AccursedArm extends TgDeviceForm
    native(ChampAndroxus);

var bool m_bShouldBeActive;
var float m_fActivationTime;
var float m_fCurrentActivationPercent;
var MaterialInterface m_cachedWeaponMaterial;
var MaterialInstanceConstant m_accursedArmMaterial;
var name m_nmUltimateActive;

// Export UTgDeviceForm_AccursedArm::execCacheAccursedArmMaterial(FFrame&, void* const)
native simulated function CacheAccursedArmMaterial();

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    // End:0x218
    if(PawnOwner != none)
    {
        // End:0x218
        if(PawnOwner.m_WeaponMesh != none)
        {
            // End:0x188
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                CacheAccursedArmMaterial();
                // End:0x131
                if(m_accursedArmMaterial != none)
                {
                    m_cachedWeaponMaterial = PawnOwner.m_WeaponMesh.m_WeaponMesh1P.GetMaterial(2);
                    PawnOwner.m_WeaponMesh.m_WeaponMesh1P.SetMaterial(2, m_accursedArmMaterial);
                }
                PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup(m_nmUltimateActive, 0);
            }
            // End:0x218
            if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup(m_nmUltimateActive, 0);
            }
        }
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event StopFire(int nFireModeNum)
{
    local TgPawn_Androxus androxus;

    androxus = TgPawn_Androxus(PawnOwner);
    // End:0x1C1
    if(androxus != none)
    {
        // End:0x133
        if((androxus.m_WeaponMesh != none) && androxus.m_WeaponMesh.m_WeaponMesh1P != none)
        {
            androxus.m_WeaponMesh.m_WeaponMesh1P.SetMaterial(2, m_cachedWeaponMaterial);
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup(m_nmUltimateActive, 0);
        }
        // End:0x1C1
        if(PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup(m_nmUltimateActive, 0);
        }
    }
    super.StopFire(nFireModeNum);
    //return;    
}

defaultproperties
{
    m_fActivationTime=0.4000000
    m_nmUltimateActive="UltimateActive"
}