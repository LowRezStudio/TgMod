class TgDeviceForm_Valor extends TgDeviceForm;

simulated event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo)
{
    super.Hit(nFireMode, Target, fDamageAmount, HitLocation, HitNormal, ExtraInfo);
    // End:0xB3
    if((PawnOwner != none) && PawnOwner.m_WeaponMesh != none)
    {
        PawnOwner.m_WeaponMesh.PlayTracerEffects(HitLocation, 1);
    }
    //return;    
}
