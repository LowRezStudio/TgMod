class TgDevice_DualWield extends TgDevice
    native(Devices)
    hidecategories(Navigation);

var() Vector m_vProjectileSpawnOffset2;
var bool m_bFireLeftWeapon;

simulated event Vector GetProjectileSpawnOffset()
{
    // End:0x1A
    if(m_bFireLeftWeapon)
    {
        return m_vProjectileSpawnOffset2;        
    }
    else
    {
        return m_vProjectileSpawnOffset;
    }
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    super.FireAmmunition();
    SetLeftFire(!m_bFireLeftWeapon);
    //return;    
}

simulated function SetLeftFire(bool bLeftFire)
{
    m_bFireLeftWeapon = bLeftFire;
    //return;    
}

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-20.0000000,Z=-10.0000000)
    m_bAimThroughReticule=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fMeshFOV=45.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=20.0000000,Z=-10.0000000)
}