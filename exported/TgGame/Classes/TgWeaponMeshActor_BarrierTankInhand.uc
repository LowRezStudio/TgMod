class TgWeaponMeshActor_BarrierTankInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var bool m_bHasFinishedBurst;

simulated function PlayFireAnimation(int nEquipSlot, float fRefireTime)
{
    // End:0x2D
    if(nEquipSlot != 1)
    {
        super.PlayFireAnimation(nEquipSlot, fRefireTime);
        return;
    }
    // End:0x61
    if(m_bHasFinishedBurst)
    {
        m_bHasFinishedBurst = false;
        super.PlayFireAnimation(nEquipSlot, 0.6000000);        
    }
    else
    {
        // End:0x80
        if(fRefireTime > 0.3000000)
        {
            m_bHasFinishedBurst = true;
        }
    }
    //return;    
}

simulated function StopFireEffects(int nEquipSlot)
{
    super.StopFireEffects(nEquipSlot);
    m_bHasFinishedBurst = true;
    //return;    
}

defaultproperties
{
    m_bHasFinishedBurst=true
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_BarrierTankInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}