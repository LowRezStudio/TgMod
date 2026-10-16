class TgWeaponMeshActor_LongbowInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var TgPawn_Longbow m_CachedLongbow;
var bool m_bPlayingPlantedFireSFX;
var bool m_bPlayingUltimateFireSFX;

simulated function bool HasCachedLongbow()
{
    // End:0x38
    if(m_CachedLongbow == none)
    {
        m_CachedLongbow = TgPawn_Longbow(Instigator);
        return m_CachedLongbow != none;
    }
    return true;
    //return ReturnValue;    
}

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode)
{
    local bool bIsInPlanted, bIsInUltimate;

    // End:0xF0
    if((HasCachedLongbow()) && nEquipSlot == 1)
    {
        // End:0x87
        if(m_CachedLongbow.GetDeviceByEqPoint(2) != none)
        {
            bIsInUltimate = m_CachedLongbow.GetDeviceByEqPoint(2).IsFiring();
        }
        // End:0xF0
        if(m_CachedLongbow.GetDeviceByEqPoint(3) != none)
        {
            bIsInPlanted = m_CachedLongbow.GetDeviceByEqPoint(3).IsFiring();
        }
    }
    // End:0x114
    if(bIsInUltimate)
    {
        UseUltimateFireSounds(bIsInUltimate);        
    }
    else
    {
        // End:0x138
        if(bIsInPlanted)
        {
            UsePlantedFireSounds(bIsInPlanted);            
        }
        else
        {
            UseUltimateFireSounds(false);
            UsePlantedFireSounds(false);
        }
    }
    super.PlayFireEffects(nEquipSlot, fRefireTime, nFireMode);
    //return;    
}

simulated function UsePlantedFireSounds(bool bShouldUse)
{
    // End:0xA7
    if(bShouldUse && !m_bPlayingPlantedFireSFX)
    {
        m_bPlayingUltimateFireSFX = false;
        // End:0x61
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.SetFireDisplayGroup('ShaLinPlantedFire');
        }
        // End:0x98
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.SetFireDisplayGroup('ShaLinPlantedFire');
        }
        m_bPlayingPlantedFireSFX = true;        
    }
    else
    {
        // End:0x13F
        if(!bShouldUse && m_bPlayingPlantedFireSFX)
        {
            // End:0xFC
            if(m_WeaponMesh1P != none)
            {
                m_WeaponMesh1P.SetFireDisplayGroup('Fire');
            }
            // End:0x133
            if(m_WeaponMesh3P != none)
            {
                m_WeaponMesh3P.SetFireDisplayGroup('Fire');
            }
            m_bPlayingPlantedFireSFX = false;
        }
    }
    //return;    
}

simulated function UseUltimateFireSounds(bool bShouldUse)
{
    // End:0xA7
    if(bShouldUse && !m_bPlayingUltimateFireSFX)
    {
        m_bPlayingPlantedFireSFX = false;
        // End:0x61
        if(m_WeaponMesh1P != none)
        {
            m_WeaponMesh1P.SetFireDisplayGroup('ShaLinUltimateFire');
        }
        // End:0x98
        if(m_WeaponMesh3P != none)
        {
            m_WeaponMesh3P.SetFireDisplayGroup('ShaLinUltimateFire');
        }
        m_bPlayingUltimateFireSFX = true;        
    }
    else
    {
        // End:0x13F
        if(!bShouldUse && m_bPlayingUltimateFireSFX)
        {
            // End:0xFC
            if(m_WeaponMesh1P != none)
            {
                m_WeaponMesh1P.SetFireDisplayGroup('Fire');
            }
            // End:0x133
            if(m_WeaponMesh3P != none)
            {
                m_WeaponMesh3P.SetFireDisplayGroup('Fire');
            }
            m_bPlayingUltimateFireSFX = false;
        }
    }
    //return;    
}

defaultproperties
{
    m_PlayFireEffectsOn[1]=TG_PLAY_FIRE_EFFECT_ON.Fire
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_LongbowInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}