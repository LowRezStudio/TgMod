class TgDevice_FireInAir extends TgDevice
    native(Devices)
    hidecategories(Navigation);

// Export UTgDevice_FireInAir::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
}