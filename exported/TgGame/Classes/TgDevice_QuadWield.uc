class TgDevice_QuadWield extends TgDevice_DualWield
    hidecategories(Navigation);

var() Vector m_vProjectileSpawnOffset3;
var() Vector m_vProjectileSpawnOffset4;
var int m_nWeaponFireNumber;

simulated event Vector GetProjectileSpawnOffset()
{
    switch(m_nWeaponFireNumber)
    {
        // End:0x21
        case 1:
            return m_vProjectileSpawnOffset;
        // End:0x30
        case 2:
            return m_vProjectileSpawnOffset2;
        // End:0x3F
        case 3:
            return m_vProjectileSpawnOffset3;
        // End:0x4E
        case 4:
            return m_vProjectileSpawnOffset4;
        // End:0xFFFF
        default:
            return super.GetProjectileSpawnOffset();
            break;
    }
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    super.FireAmmunition();
    m_nWeaponFireNumber++;
    // End:0x30
    if(m_nWeaponFireNumber > 4)
    {
        m_nWeaponFireNumber = 1;
    }
    //return;    
}

defaultproperties
{
    m_vProjectileSpawnOffset3=(X=30.0000000,Y=20.0000000,Z=10.0000000)
    m_vProjectileSpawnOffset4=(X=30.0000000,Y=-20.0000000,Z=-10.0000000)
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-20.0000000,Z=10.0000000)
}