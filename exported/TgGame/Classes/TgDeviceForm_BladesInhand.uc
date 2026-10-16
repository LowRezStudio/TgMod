class TgDeviceForm_BladesInhand extends TgDeviceForm
    native(Devices);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    // End:0x6A
    if(PawnOwner != none)
    {
        PawnOwner.FxDeactivateGroupWeapon('Generic1', 0);
        PawnOwner.FxActivateGroupWeapon('Generic1', 0, 0, 0, false, true);
    }
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    //return;    
}
