class TgDeviceForm_SpinnerWhileFiring extends TgDeviceForm
    native(Devices);

var const name m_SpinnerName;
var array<TgSkelCon_Spinner> m_SpinnerSkelControls1p;
var array<TgSkelCon_Spinner> m_SpinnerSkelControls3p;

// Export UTgDeviceForm_SpinnerWhileFiring::execCacheSkelControls(FFrame&, void* const)
native function CacheSkelControls(AnimTree pAnimTree, out array<TgSkelCon_Spinner> SpinnerSkelControls);

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache1PAnimNodes(SkelComp);
    CacheSpinner(SkelComp, m_SpinnerSkelControls1p);
    //return;    
}

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super.Cache3PAnimNodes(SkelComp);
    CacheSpinner(SkelComp, m_SpinnerSkelControls3p);
    //return;    
}

function CacheSpinner(TgSkeletalMeshComponent SkelComp, out array<TgSkelCon_Spinner> SpinnerSkelControls)
{
    SpinnerSkelControls.Remove(0, SpinnerSkelControls.Length);
    // End:0x4D
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    CacheSkelControls(AnimTree(SkelComp.Animations), SpinnerSkelControls);
    //return;    
}

function SetSpinnersActive(bool bActive)
{
    local TgSkelCon_Spinner Spinner;

    // End:0x41
    foreach m_SpinnerSkelControls1p(Spinner)
    {
        Spinner.Spin(bActive);        
    }    
    // End:0x83
    foreach m_SpinnerSkelControls3p(Spinner)
    {
        Spinner.Spin(bActive);        
    }    
    //return;    
}

function SetSpinnersRotationSpeedState(int nState)
{
    local TgSkelCon_Spinner Spinner;

    // End:0x40
    foreach m_SpinnerSkelControls1p(Spinner)
    {
        Spinner.m_nRotationSpeedState = nState;        
    }    
    // End:0x81
    foreach m_SpinnerSkelControls3p(Spinner)
    {
        Spinner.m_nRotationSpeedState = nState;        
    }    
    //return;    
}
