class TgDeviceForm_RuckusInhand extends TgDeviceForm
    native(ChampRuckus);

var bool m_bFiredFromLeftGun;
var bool m_bFiredFromTopBarrel;
var bool m_bPlayingSpinnerSound;
var bool m_bPlayingFireLoopSound;
var bool m_bIsFiring;
var TgSkelCon_Spinner m_SpinnerSkelControl1P;
var TgSkelCon_Spinner m_SpinnerSkelControl3P;
var name c_nmSocketLeft;
var name c_nmSocketRight;
var() float m_fLoopingSoundThreshold;
var float m_fLastSpinConfirmationTimestamp;
var float m_fSpinConfirmationCooldown;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel1P;
var TgSkelControlSingleBone_PistonBarrel m_LowerRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperRightBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_LowerLeftBarrel3P;
var TgSkelControlSingleBone_PistonBarrel m_UpperLeftBarrel3P;

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
    m_bIsFiring = true;
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    m_bIsFiring = false;
    //return;    
}

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

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local TgPawn_Ruckus Ruckus;

    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    Ruckus = TgPawn_Ruckus(PawnOwner);
    // End:0x837
    if(Ruckus != none)
    {
        m_bFiredFromLeftGun = !m_bFiredFromLeftGun;
        // End:0xB9
        if(!m_bFiredFromLeftGun)
        {
            m_bFiredFromTopBarrel = !m_bFiredFromTopBarrel;
        }
        // End:0x481
        if(!m_bFiredFromLeftGun)
        {
            // End:0x2AB
            if((Ruckus.m_WeaponMesh != none) && Ruckus.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('MuzzleFlashLeft', 0);
                Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('MuzzleFlashLeft', 0);
                // End:0x2AB
                if(Ruckus.r_fBarrelSpinFactor < m_fLoopingSoundThreshold)
                {
                    Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('RuckusSingleFireLeft', 0);
                    Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('RuckusSingleFireLeft', 0);
                }
            }
            // End:0x3B6
            if((Ruckus.m_WeaponMesh != none) && Ruckus.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                Ruckus.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('MuzzleFlashLeft', 0);
                Ruckus.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('MuzzleFlashLeft', 0);
            }
            // End:0x422
            if(m_bFiredFromTopBarrel)
            {
                // End:0x3F1
                if(m_UpperLeftBarrel1P != none)
                {
                    m_UpperLeftBarrel1P.Depress();
                }
                // End:0x41F
                if(m_UpperLeftBarrel3P != none)
                {
                    m_UpperLeftBarrel3P.Depress();
                }                
            }
            else
            {
                // End:0x450
                if(m_LowerLeftBarrel1P != none)
                {
                    m_LowerLeftBarrel1P.Depress();
                }
                // End:0x47E
                if(m_LowerLeftBarrel3P != none)
                {
                    m_LowerLeftBarrel3P.Depress();
                }
            }            
        }
        else
        {
            // End:0x664
            if((Ruckus.m_WeaponMesh != none) && Ruckus.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('MuzzleFlashRight', 0);
                Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('MuzzleFlashRight', 0);
                // End:0x664
                if(Ruckus.r_fBarrelSpinFactor < m_fLoopingSoundThreshold)
                {
                    Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('RuckusSingleFireRight', 0);
                    Ruckus.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('RuckusSingleFireRight', 0);
                }
            }
            // End:0x76F
            if((Ruckus.m_WeaponMesh != none) && Ruckus.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                Ruckus.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('MuzzleFlashRight', 0);
                Ruckus.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('MuzzleFlashRight', 0);
            }
            // End:0x7DB
            if(m_bFiredFromTopBarrel)
            {
                // End:0x7AA
                if(m_UpperRightBarrel1P != none)
                {
                    m_UpperRightBarrel1P.Depress();
                }
                // End:0x7D8
                if(m_UpperRightBarrel3P != none)
                {
                    m_UpperRightBarrel3P.Depress();
                }                
            }
            else
            {
                // End:0x809
                if(m_LowerRightBarrel1P != none)
                {
                    m_LowerRightBarrel1P.Depress();
                }
                // End:0x837
                if(m_LowerRightBarrel3P != none)
                {
                    m_LowerRightBarrel3P.Depress();
                }
            }
        }
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
    // End:0x108
    if(PawnOwner.IsFirstPerson())
    {
        // End:0xBE
        if(!m_bFiredFromLeftGun)
        {
            socketPos = PawnOwner.GetWeaponStartTraceLocationAlt(Class'TgGame.TgDevice_RuckusInhand'.default.m_vProjectileSpawnOffset2);            
        }
        else
        {
            socketPos = PawnOwner.GetWeaponStartTraceLocationAlt(Class'TgGame.TgDevice_RuckusInhand'.default.m_vProjectileSpawnOffset);
        }        
    }
    else
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(((!m_bFiredFromLeftGun) ? c_nmSocketLeft : c_nmSocketRight), socketPos, socketRot);
    }
    return socketPos;
    //return ReturnValue;    
}

defaultproperties
{
    m_bFiredFromTopBarrel=true
    c_nmSocketLeft="WSO_Emit_02"
    c_nmSocketRight="WSO_Emit_01"
    m_fLoopingSoundThreshold=0.9500000
    m_fSpinConfirmationCooldown=1.0000000
}