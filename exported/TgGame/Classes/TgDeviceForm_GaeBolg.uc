class TgDeviceForm_GaeBolg extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgPawn_BarrierTank inaraPawn;

    // End:0x14A
    if(PawnOwner != none)
    {
        inaraPawn = TgPawn_BarrierTank(PawnOwner);
        // End:0x14A
        if(inaraPawn != none)
        {
            inaraPawn.m_bUseGaeBolgRetrieve = true;
            inaraPawn.m_fZoomDurationOverride = 0.1000000;
            inaraPawn.m_fZoomDistOverride = 0.5000000;
            // End:0x14A
            if(inaraPawn.Mesh != none)
            {
                inaraPawn.Mesh.FxActivateIndependant('UltimateActivated', 0, inaraPawn.Location, Vector(inaraPawn.Rotation));
            }
        }
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    local TgPawn_BarrierTank inaraPawn;

    // End:0xB3
    if(PawnOwner != none)
    {
        inaraPawn = TgPawn_BarrierTank(PawnOwner);
        // End:0xB3
        if(inaraPawn != none)
        {
            inaraPawn.m_bUseGaeBolgRetrieve = true;
            inaraPawn.m_fZoomDurationOverride = 0.1000000;
            inaraPawn.m_fZoomDistOverride = 0.0000000;
        }
    }
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    //return;    
}

event DoInterrupt()
{
    local TgPawn_BarrierTank inaraPawn;

    super.DoInterrupt();
    // End:0xAD
    if(PawnOwner != none)
    {
        inaraPawn = TgPawn_BarrierTank(PawnOwner);
        // End:0xAD
        if(inaraPawn != none)
        {
            inaraPawn.m_bUseGaeBolgRetrieve = false;
            inaraPawn.m_fZoomDurationOverride = 0.1000000;
            inaraPawn.m_fZoomDistOverride = 0.0000000;
        }
    }
    //return;    
}
