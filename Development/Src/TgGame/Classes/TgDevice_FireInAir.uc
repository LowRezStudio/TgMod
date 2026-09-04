class TgDevice_FireInAir extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine);

native function bool MustBeOnGroundToFire();  // Export UTgDevice_FireInAir::execMustBeOnGroundToFire(FFrame&, void* const)

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
}
