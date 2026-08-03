class TgDeviceForm_TyraInhand extends TgDeviceForm;

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    local TgPlayerController PC;

    super.Hit(nFireMode, Target, fDamageAmount, HitLocation, HitNormal, ExtraInfo);
    // End:0x1EE
    if(((ExtraInfo.bMarked && PawnOwner != none) && PawnOwner.m_WeaponMesh != none) && PawnOwner.m_WeaponMesh.m_WeaponMesh1P != none)
    {
        PC = TgPlayerController(PawnOwner.GetALocalPlayerController());
        // End:0x1EE
        if((PC != none) && PC.GetTgPawn() == PawnOwner)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('Generic1', 0);
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('Generic1', 0);
        }
    }
    //return;    
}
