class TgDeviceForm_HexaFireGuns extends TgDeviceForm;

var TgSkelCon_Spinner m_SpinnerSkelControl1P;
var TgSkelCon_Spinner m_SpinnerSkelControl3P;
var int m_nNextGunFired;
var name c_nmSocket1;
var name c_nmSocket2;
var name c_nmSocket3;
var name c_nmSocket4;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel3P;

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    m_LowerRightBarrel1P = none;
    m_UpperRightBarrel1P = none;
    m_LowerLeftBarrel1P = none;
    m_UpperLeftBarrel1P = none;
    m_SpinnerSkelControl1P = none;
    CacheAnimNodesHelper(SkelComp, m_LowerRightBarrel1P, m_UpperRightBarrel1P, m_LowerLeftBarrel1P, m_UpperLeftBarrel1P, m_SpinnerSkelControl1P);
    //return;    
}

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    m_LowerRightBarrel3P = none;
    m_UpperRightBarrel3P = none;
    m_LowerLeftBarrel3P = none;
    m_UpperLeftBarrel3P = none;
    m_SpinnerSkelControl3P = none;
    CacheAnimNodesHelper(SkelComp, m_LowerRightBarrel3P, m_UpperRightBarrel3P, m_LowerLeftBarrel3P, m_UpperLeftBarrel3P, m_SpinnerSkelControl3P);
    //return;    
}

function CacheAnimNodesHelper(TgSkeletalMeshComponent SkelComp, out TgSkelControlSingleBone_PistonBarrel LowerRightBarrel, out TgSkelControlSingleBone_PistonBarrel UpperRightBarrel, out TgSkelControlSingleBone_PistonBarrel LowerLeftBarrel, out TgSkelControlSingleBone_PistonBarrel UpperLeftBarrel, out TgSkelCon_Spinner Spinner)
{
    // End:0x37
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    LowerRightBarrel = TgSkelControlSingleBone_PistonBarrel(SkelComp.FindSkelControl('RT_LowerPistonBarrels'));
    UpperRightBarrel = TgSkelControlSingleBone_PistonBarrel(SkelComp.FindSkelControl('RT_UpperPistonBarrels'));
    LowerLeftBarrel = TgSkelControlSingleBone_PistonBarrel(SkelComp.FindSkelControl('LT_LowerPistonBarrels'));
    UpperLeftBarrel = TgSkelControlSingleBone_PistonBarrel(SkelComp.FindSkelControl('LT_UpperPistonBarrels'));
    Spinner = TgSkelCon_Spinner(SkelComp.FindSkelControl('Spinner'));
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x60
    if(m_SpinnerSkelControl1P != none)
    {
        m_SpinnerSkelControl1P.Spin(true);
    }
    // End:0x8F
    if(m_SpinnerSkelControl3P != none)
    {
        m_SpinnerSkelControl3P.Spin(true);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x42
    if(m_SpinnerSkelControl1P != none)
    {
        m_SpinnerSkelControl1P.Spin(false);
    }
    // End:0x71
    if(m_SpinnerSkelControl3P != none)
    {
        m_SpinnerSkelControl3P.Spin(false);
    }
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local TgSkelControlSingleBone_PistonBarrel barrel1p, barrel3p;

    // End:0x89
    if((HitLocation != vect(0.0000000, 0.0000000, 0.0000000)) && ModeDatas[c_nFireMode].c_FxInstantFire)
    {
        PlayImpactEffects(HitLocation, nEquipSlot, nSocketIndex, bSuccessfulHit);
    }
    // End:0xD2
    if(PawnOwner != none)
    {
        PawnOwner.OnDeviceFormFire(c_nEquipSlot, fRefireTime, nFireMode);
    }
    switch(m_nNextGunFired)
    {
        // End:0x125
        case 1:
            ActivateFxGroup('HexaFire_MuzzleFlash1');
            barrel1p = m_UpperLeftBarrel1P;
            barrel3p = m_UpperLeftBarrel3P;
            // End:0x1EB
            break;
        // End:0x166
        case 2:
            ActivateFxGroup('HexaFire_MuzzleFlash2');
            barrel1p = m_LowerLeftBarrel1P;
            barrel3p = m_LowerLeftBarrel3P;
            // End:0x1EB
            break;
        // End:0x1A7
        case 3:
            ActivateFxGroup('HexaFire_MuzzleFlash3');
            barrel1p = m_UpperRightBarrel1P;
            barrel3p = m_UpperRightBarrel3P;
            // End:0x1EB
            break;
        // End:0x1E8
        case 4:
            ActivateFxGroup('HexaFire_MuzzleFlash4');
            barrel1p = m_LowerRightBarrel1P;
            barrel3p = m_LowerRightBarrel3P;
            // End:0x1EB
            break;
        // End:0xFFFF
        default:
            break;
    }
    // End:0x219
    if(barrel1p != none)
    {
        barrel1p.Depress();
    }
    // End:0x247
    if(barrel3p != none)
    {
        barrel3p.Depress();
    }
    m_nNextGunFired++;
    // End:0x26D
    if(m_nNextGunFired > 4)
    {
        m_nNextGunFired = 1;
    }
    //return;    
}

event Vector GetTracerSocketLocation()
{
    local Vector socketPos;
    local Rotator socketRot;

    // End:0x43
    if((PawnOwner == none) || PawnOwner.Mesh == none)
    {
        return vect(0.0000000, 0.0000000, 0.0000000);
    }
    // End:0x203
    if(PawnOwner.IsFirstPerson())
    {
        switch(m_nNextGunFired)
        {
            // End:0xC6
            case 1:
                socketPos = PawnOwner.GetWeaponStartTraceLocationAlt(Class'TgGame.TgDevice_HexaFireGuns'.default.m_vProjectileSpawnOffset);
                // End:0x200
                break;
            // End:0x115
            case 2:
                socketPos = PawnOwner.GetWeaponStartTraceLocationAlt(Class'TgGame.TgDevice_HexaFireGuns'.default.m_vProjectileSpawnOffset2);
                // End:0x200
                break;
            // End:0x164
            case 3:
                socketPos = PawnOwner.GetWeaponStartTraceLocationAlt(Class'TgGame.TgDevice_HexaFireGuns'.default.m_vProjectileSpawnOffset3);
                // End:0x200
                break;
            // End:0x1B3
            case 4:
                socketPos = PawnOwner.GetWeaponStartTraceLocationAlt(Class'TgGame.TgDevice_HexaFireGuns'.default.m_vProjectileSpawnOffset4);
                // End:0x200
                break;
            // End:0xFFFF
            default:
                socketPos = PawnOwner.GetWeaponStartTraceLocationAlt(Class'TgGame.TgDevice_HexaFireGuns'.default.m_vProjectileSpawnOffset);
                // End:0x200
                break;
                break;
        }        
    }
    else
    {
        switch(m_nNextGunFired)
        {
            // End:0x282
            case 1:
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(c_nmSocket1, socketPos, socketRot);
                // End:0x434
                break;
            // End:0x2EF
            case 2:
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(c_nmSocket2, socketPos, socketRot);
                // End:0x434
                break;
            // End:0x35C
            case 3:
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(c_nmSocket3, socketPos, socketRot);
                // End:0x434
                break;
            // End:0x3C9
            case 4:
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(c_nmSocket4, socketPos, socketRot);
                // End:0x434
                break;
            // End:0xFFFF
            default:
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(c_nmSocket1, socketPos, socketRot);
                // End:0x434
                break;
                break;
        }
    }
    return socketPos;
    //return ReturnValue;    
}

defaultproperties
{
    m_nNextGunFired=1
    c_nmSocket1="WSO_Emit_01"
    c_nmSocket2="WSO_Emit_02"
    c_nmSocket3="WSO_Emit_03"
    c_nmSocket4="WSO_Emit_04"
    m_bUseImpactFXOverride=true
}