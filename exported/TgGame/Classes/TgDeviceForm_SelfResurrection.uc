class TgDeviceForm_SelfResurrection extends TgDeviceForm
    native(ChampLazarus);

var TgDevice_SelfResurrection.ResurrectionState m_CurrentDeviceState;

event Generic1(optional byte byExtraData)
{
    local TgPawn_Lazarus pLazarus;

    m_CurrentDeviceState = byExtraData;
    pLazarus = TgPawn_Lazarus(PawnOwner);
    // End:0xE1
    if(pLazarus != none)
    {
        // End:0x76
        if(int(m_CurrentDeviceState) == int(2))
        {
            pLazarus.FakeDeath(none);            
        }
        else
        {
            // End:0xAE
            if(int(m_CurrentDeviceState) == int(0))
            {
                pLazarus.m_bHasPlayedDeathAnimation = false;                
            }
            else
            {
                // End:0xE1
                if(int(m_CurrentDeviceState) == int(3))
                {
                    pLazarus.TermRagdoll();
                }
            }
        }
    }
    super.Generic1(byExtraData);
    //return;    
}
