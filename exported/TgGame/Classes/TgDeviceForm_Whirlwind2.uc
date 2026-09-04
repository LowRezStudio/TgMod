class TgDeviceForm_Whirlwind2 extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    // End:0x36
    if(PawnOwner != none)
    {
        PawnOwner.m_fZoomDistOverride = 2.0000000;
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event DoInterrupt()
{
    // End:0x33
    if(PawnOwner != none)
    {
        PawnOwner.m_fZoomDistOverride = 0.0000000;
    }
    super.DoInterrupt();
    //return;    
}

event StopFire(int nFireModeNum)
{
    // End:0x33
    if(PawnOwner != none)
    {
        PawnOwner.m_fZoomDistOverride = 0.0000000;
    }
    super.StopFire(nFireModeNum);
    //return;    
}
