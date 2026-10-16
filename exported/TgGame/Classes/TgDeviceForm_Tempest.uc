class TgDeviceForm_Tempest extends TgDeviceForm
    native(ChampGrohk);

var Actor m_BeamTarget1;
var Actor m_BeamTarget2;
var bool m_bBeamActive1;
var bool m_bBeamActive2;
var bool m_bBeamDirty1;
var bool m_bBeamDirty2;
var float m_fBeamStartTime1;
var float m_fBeamStartTime2;
var const float m_fBeamOnTime;

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    StopArcingBeamEffects();
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    m_bBeamDirty1 = true;
    m_bBeamDirty2 = true;
    //return;    
}

event SetTargetArcingBeamEffect(Actor Target)
{
    // End:0x2A
    if((FormState != 'DeviceFiring') || PawnOwner == none)
    {
        return;
    }
    // End:0x1CF
    if((m_BeamTarget1 == none) || m_bBeamDirty1)
    {
        m_BeamTarget1 = Target;
        m_bBeamActive1 = true;
        m_bBeamDirty1 = false;
        m_fBeamStartTime1 = PawnOwner.WorldInfo.TimeSeconds;
        // End:0x1CC
        if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('Grohk_Tempest1', 0);
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('Grohk_Tempest1', 0);
        }        
    }
    else
    {
        // End:0x371
        if((m_BeamTarget2 == none) || m_bBeamDirty2)
        {
            m_BeamTarget2 = Target;
            m_bBeamActive2 = true;
            m_bBeamDirty2 = false;
            m_fBeamStartTime2 = PawnOwner.WorldInfo.TimeSeconds;
            // End:0x371
            if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
            {
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('Grohk_Tempest2', 0);
                PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxActivateGroup('Grohk_Tempest2', 0);
            }
        }
    }
    //return;    
}

function StopArcingBeamEffects()
{
    m_BeamTarget1 = none;
    m_BeamTarget2 = none;
    m_bBeamActive1 = false;
    m_bBeamActive2 = false;
    m_bBeamDirty1 = false;
    m_bBeamDirty2 = false;
    // End:0x10B
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('Grohk_Tempest1', 0);
    }
    // End:0x1D0
    if(((PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh3P != none)
    {
        PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxDeactivateGroup('Grohk_Tempest2', 0);
    }
    //return;    
}

defaultproperties
{
    m_fBeamOnTime=0.2000000
}