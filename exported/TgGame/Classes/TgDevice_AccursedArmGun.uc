class TgDevice_AccursedArmGun extends TgDevice
    native(ChampAndroxus)
    hidecategories(Navigation);

var TgDevice_AccursedArm m_AccursedArm;

// Export UTgDevice_AccursedArmGun::execRequiresAmmoToFire(FFrame&, void* const)
native function bool RequiresAmmoToFire();

// Export UTgDevice_AccursedArmGun::execShouldTreatAmmoAsCharges(FFrame&, void* const)
native function bool ShouldTreatAmmoAsCharges();

// Export UTgDevice_AccursedArmGun::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

simulated function FireAmmunition()
{
    super.FireAmmunition();
    // End:0x60
    if(((int(Role) == int(ROLE_Authority)) && (GetCurrentAmmoAmount()) <= 0) && m_AccursedArm != none)
    {
        m_AccursedArm.OnGunEmptied();
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    local TgDevice_AccursedArm AccursedArm;

    super.LinkedDeviceEquipped(Dev);
    AccursedArm = TgDevice_AccursedArm(Dev);
    // End:0x51
    if(AccursedArm != none)
    {
        m_AccursedArm = AccursedArm;
    }
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    local TgDevice_AccursedArm AccursedArm;

    super.LinkedDeviceUnequipped(Dev);
    AccursedArm = TgDevice_AccursedArm(Dev);
    // End:0x62
    if((AccursedArm != none) && m_AccursedArm == AccursedArm)
    {
        m_AccursedArm = none;
    }
    //return;    
}

simulated event OnLinkDevice(TgPawn TgP)
{
    local TgPawn_Androxus androxus;

    super.OnLinkDevice(TgP);
    androxus = TgPawn_Androxus(TgP);
    // End:0xAA
    if(((androxus != none) && !androxus.bDeleteMe) && !androxus.bPendingDelete)
    {
        androxus.m_AccursedArmInHand = self;
    }
    //return;    
}

simulated event OnUnlinkDevice(TgPawn TgP)
{
    local TgPawn_Androxus androxus;

    super.OnUnlinkDevice(TgP);
    androxus = TgPawn_Androxus(TgP);
    // End:0xD0
    if((((androxus != none) && !androxus.bDeleteMe) && !androxus.bPendingDelete) && androxus.m_AccursedArmInHand == self)
    {
        androxus.m_AccursedArmInHand = none;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=13254
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Androxus.DeviceAccursedArm'
}