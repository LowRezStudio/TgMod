class TgWeaponMeshActor_RuckusInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var export editinline TgMuzzleFlash m_SecondaryMuzzleFlashLight;

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint = true)
{
    super.InitializeForWeapon(EquipPoint, DeviceID, bClearEquipPoint);
    SetFireLoopDisplayGroup('DualFire', Class'TgGame.TgSkeletalMeshComponent_Weapon'.default.m_nmFireLoopTailSound);
    //return;    
}

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode)
{
    // End:0x30
    if(nEquipSlot == 18)
    {
        super.PlayFireEffects(1, fRefireTime, nFireMode);        
    }
    else
    {
        super.PlayFireEffects(nEquipSlot, fRefireTime, nFireMode);
    }
    //return;    
}

simulated function StopFireEffects(int nEquipSlot)
{
    // End:0x1E
    if(nEquipSlot == 18)
    {
        super.StopFireEffects(1);        
    }
    else
    {
        super.StopFireEffects(nEquipSlot);
    }
    //return;    
}

simulated function OverrideTracerFireLoc(out Vector fireLoc)
{
    local TgPawn_Ruckus Ruckus;
    local TgDevice RuckusInhandDevice;
    local TgDeviceForm_RuckusInhand RuckusInhandForm;
    local TgDeviceForm_HexaFireGuns RuckusHexaFireForm;

    Ruckus = TgPawn_Ruckus(Owner);
    // End:0x1F4
    if(Ruckus != none)
    {
        // End:0xF8
        if(IsFirstPerson())
        {
            // End:0x8B
            if(Ruckus.r_bHexaFireFiring)
            {
                RuckusInhandDevice = Ruckus.GetDeviceById(13219);                
            }
            else
            {
                RuckusInhandDevice = Ruckus.GetDeviceByEqPoint(1);
            }
            // End:0xF8
            if(RuckusInhandDevice != none)
            {
                fireLoc = Ruckus.GetWeaponStartTraceLocation(RuckusInhandDevice);
                return;
            }
        }
        // End:0x189
        if(Ruckus.r_bHexaFireFiring)
        {
            RuckusHexaFireForm = TgDeviceForm_HexaFireGuns(Ruckus.c_EquipForm[18]);
            // End:0x186
            if(RuckusHexaFireForm != none)
            {
                fireLoc = RuckusHexaFireForm.GetTracerSocketLocation();
            }            
        }
        else
        {
            RuckusInhandForm = TgDeviceForm_RuckusInhand(Ruckus.c_EquipForm[1]);
            // End:0x1F4
            if(RuckusInhandForm != none)
            {
                fireLoc = RuckusInhandForm.GetTracerSocketLocation();
            }
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_RuckusInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}