class TgDevice_PrincessF extends TgDevice_Charge
    hidecategories(Navigation);

var TgDevice m_cachedSupportDevice;
var(dash) int m_nEyeheightAdjustmentWhileSliding;
var float m_fEyeHeightSmoothFactor;

simulated function bool HasCachedSupportDevice()
{
    local TgPawn TgP;

    // End:0x65
    if(m_cachedSupportDevice == none)
    {
        TgP = TgPawn(Instigator);
        // End:0x65
        if(TgP != none)
        {
            m_cachedSupportDevice = TgP.GetDeviceByEqPoint(18);
        }
    }
    return m_cachedSupportDevice != none;
    //return ReturnValue;    
}

simulated function Rotator GetChargeDirection()
{
    // End:0x96
    if((Instigator.Acceleration.X == float(0)) && Instigator.Acceleration.Y == float(0))
    {
        return Instigator.Rotation;        
    }
    else
    {
        return Rotator(Normal2D(Instigator.Acceleration));
    }
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated event StartCharge()
    {
        local TgPawn_Character TgPC;
        local TgDeviceFire FireMode;

        super.StartCharge();
        // End:0x125
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            TgPC = TgPawn_Character(Instigator);
            // End:0x125
            if(TgPC != none)
            {
                // End:0x9B
                if(m_nEyeheightAdjustmentWhileSliding != 0)
                {
                    TgPC.BaseEyeHeight += float(m_nEyeheightAdjustmentWhileSliding);                    
                }
                else
                {
                    FireMode = GetCurrentFire();
                    // End:0xFD
                    if(FireMode != none)
                    {
                        TgPC.BaseEyeHeight += FireMode.GetCustomValue1();
                    }
                }
                TgPC.m_fEyeHeightSmoothFactor = m_fEyeHeightSmoothFactor;
            }
        }
        //return;        
    }

    simulated event EndCharge()
    {
        local TgPawn_Character TgPC;
        local TgDeviceFire FireMode;

        super.EndCharge();
        // End:0x13A
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            TgPC = TgPawn_Character(Instigator);
            // End:0x13A
            if(TgPC != none)
            {
                // End:0x9B
                if(m_nEyeheightAdjustmentWhileSliding != 0)
                {
                    TgPC.BaseEyeHeight -= float(m_nEyeheightAdjustmentWhileSliding);                    
                }
                else
                {
                    FireMode = GetCurrentFire();
                    // End:0xFD
                    if(FireMode != none)
                    {
                        TgPC.BaseEyeHeight -= FireMode.GetCustomValue1();
                    }
                }
                TgPC.m_fEyeHeightSmoothFactor = Class'TgGame.TgPawn'.default.m_fEyeHeightSmoothFactor;
            }
        }
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        // End:0x36
        if(HasCachedSupportDevice())
        {
            m_cachedSupportDevice.StartFire();
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fEyeHeightSmoothFactor=4.0000000
    m_bCanLeftClickCancel=false
}