class TgDeviceForm_RestoreSoul extends TgDeviceForm;

var TgPawn_Oracle m_CachedOracle;

simulated function bool HasCachedOracle()
{
    // End:0x2B
    if(m_CachedOracle == none)
    {
        m_CachedOracle = TgPawn_Oracle(PawnOwner);
    }
    return m_CachedOracle != none;
    //return ReturnValue;    
}

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState)
{
    local TgWeaponMeshActor_OracleInhand InhandWeaponMesh;

    super.RecoverDeviceState(DesiredState);
    // End:0xDE
    if(int(DesiredState) == int(1))
    {
        // End:0xDE
        if((HasCachedOracle()) && m_CachedOracle.m_WeaponMesh != none)
        {
            InhandWeaponMesh = TgWeaponMeshActor_OracleInhand(m_CachedOracle.m_WeaponMesh);
            // End:0xDE
            if(InhandWeaponMesh != none)
            {
                InhandWeaponMesh.SetLoopingMuzzleEffects(false, 16);
                InhandWeaponMesh.SetLoopingMuzzleEffects(true, 16);
            }
        }
    }
    //return;    
}
