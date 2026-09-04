class TgDevice_Spray extends TgDevice
    hidecategories(Navigation);

var bool m_bMissedSpray;

simulated event bool ShouldCooldownAfterFire()
{
    return true;
    //return ReturnValue;    
}

function AuthStartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    local TgDeviceFire FireMode;

    // End:0x95
    if(m_bMissedSpray && fCooldownTimeOverride < 0.0000000)
    {
        // End:0x63
        if(nMode >= 0)
        {
            FireMode = GetDeviceFire(nMode);            
        }
        else
        {
            FireMode = GetCurrentFire();
        }
        // End:0x95
        if(FireMode != none)
        {
            fCooldownTimeOverride = 0.2500000;
        }
    }
    super.AuthStartCooldown(nMode, fCooldownTimeOverride);
    //return;    
}

simulated function PlayClientFireFx(Vector HitLocation, int nSocketIndex, bool bSuccessfulHit, float fRefireTime)
{
    local TgDeviceForm_Spray sprayForm;

    super.PlayClientFireFx(HitLocation, nSocketIndex, bSuccessfulHit, fRefireTime);
    // End:0xD5
    if(int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        m_bMissedSpray = !bSuccessfulHit;
        // End:0xD2
        if(!bSuccessfulHit)
        {
            sprayForm = TgDeviceForm_Spray(c_DeviceForm);
            // End:0xD2
            if(sprayForm != none)
            {
                sprayForm.PlaySprayFX(bSuccessfulHit);
            }
        }        
    }
    else
    {
        // End:0x14E
        if((int(Role) < int(ROLE_Authority)) && !bSuccessfulHit)
        {
            sprayForm = TgDeviceForm_Spray(c_DeviceForm);
            // End:0x14E
            if(sprayForm != none)
            {
                sprayForm.PlaySprayFX(bSuccessfulHit);
            }
        }
    }
    //return;    
}

function OnInstantShotVerified(ImpactInfo VerifiedPrimaryImpact)
{
    super.OnInstantShotVerified(VerifiedPrimaryImpact);
    m_bMissedSpray = VerifiedPrimaryImpact.HitLocation == vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

defaultproperties
{
    m_bStartFireShouldEnterCombat=false
    m_bFireShouldEnterCombat=false
}