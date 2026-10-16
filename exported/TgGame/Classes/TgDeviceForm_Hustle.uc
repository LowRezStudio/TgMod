class TgDeviceForm_Hustle extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x64
    if(PawnOwner != none)
    {
        PawnOwner.Bob = 0.0140000;
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x46
    if(PawnOwner != none)
    {
        PawnOwner.Bob = 0.0100000;
    }
    //return;    
}

defaultproperties
{
    m_bLoopWhileFiringCameraAnim=true
    m_fWhileFiringCameraAnimBlendOutTime=0.1500000
}