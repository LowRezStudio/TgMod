class TgDeviceFire_Mount extends TgDeviceFire;

simulated event float GetPreHitDelay()
{
    // End:0x7E
    if((m_Owner != none) && TgPawn(m_Owner.Instigator) != none)
    {
        return TgPawn(m_Owner.Instigator).GetPropCurrentValue(13);
    }
    return super.GetPreHitDelay();
    //return ReturnValue;    
}
