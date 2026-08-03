class TgDeviceForm_WeaponSwap extends TgDeviceForm
    native(ChampOwl);

var array<TgSkelControlSingleBone> m_PistolScale1p;
var array<TgSkelControlSingleBone> m_PistolScale3p;
var array<TgSkelControlSingleBone> m_RifleScale1p;
var array<TgSkelControlSingleBone> m_RifleScale3p;

// Export UTgDeviceForm_WeaponSwap::execCacheSkelControls(FFrame&, void* const)
native function CacheSkelControls(AnimTree pAnimTree, out array<TgSkelControlSingleBone> PistolSkelControls, out array<TgSkelControlSingleBone> RifleSkelControls, name nmPistol, name nmRifle);

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    CacheControls(SkelComp, m_PistolScale1p, m_RifleScale1p, 'PistolScale', 'SniperScale');
    //return;    
}

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    CacheControls(SkelComp, m_PistolScale3p, m_RifleScale3p, 'PistolScale', 'RifleScale');
    //return;    
}

function CacheControls(TgSkeletalMeshComponent SkelComp, out array<TgSkelControlSingleBone> PistolSkelControls, out array<TgSkelControlSingleBone> RifleSkelControls, name nmPistol, name nmRifle)
{
    PistolSkelControls.Remove(0, PistolSkelControls.Length);
    RifleSkelControls.Remove(0, RifleSkelControls.Length);
    // End:0x63
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    CacheSkelControls(AnimTree(SkelComp.Animations), PistolSkelControls, RifleSkelControls, nmPistol, nmRifle);
    //return;    
}

function SetSkelControlsActive(out array<TgSkelControlSingleBone> SkelControls, bool bActive)
{
    local TgSkelControlSingleBone SkelControl;

    // End:0x50
    foreach SkelControls(SkelControl)
    {
        SkelControl.BoneScale = ((bActive) ? 1.0000000 : 0.0000000);        
    }    
    //return;    
}

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState)
{
    // End:0x80
    if((int(DesiredState) == int(1)) && FormState != 'DeviceFiring')
    {
        SetSkelControlsActive(m_PistolScale1p, true);
        SetSkelControlsActive(m_PistolScale3p, true);
        SetSkelControlsActive(m_RifleScale1p, false);
        SetSkelControlsActive(m_RifleScale3p, false);        
    }
    else
    {
        // End:0xFD
        if((int(DesiredState) == int(0)) && FormState == 'DeviceFiring')
        {
            SetSkelControlsActive(m_PistolScale1p, false);
            SetSkelControlsActive(m_PistolScale3p, false);
            SetSkelControlsActive(m_RifleScale1p, true);
            SetSkelControlsActive(m_RifleScale3p, true);
        }
    }
    super.RecoverDeviceState(DesiredState);
    //return;    
}
