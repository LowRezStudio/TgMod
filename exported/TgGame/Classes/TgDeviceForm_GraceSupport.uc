class TgDeviceForm_GraceSupport extends TgDeviceForm;

var TgWeaponMeshActor_LianInhand m_CachedWMA;

function bool HasCachedWMA()
{
    // End:0x4F
    if(m_CachedWMA == none)
    {
        // End:0x4F
        if(PawnOwner != none)
        {
            m_CachedWMA = TgWeaponMeshActor_LianInhand(PawnOwner.m_WeaponMesh);
        }
    }
    return m_CachedWMA != none;
    //return ReturnValue;    
}

simulated event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x5D
    if(HasCachedWMA())
    {
        m_CachedWMA.ShowGraceTracers();
    }
    //return;    
}

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
