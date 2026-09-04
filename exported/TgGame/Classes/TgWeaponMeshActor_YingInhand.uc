class TgWeaponMeshActor_YingInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var bool m_bHasFinishedBurst;

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint = true)
{
    super.InitializeForWeapon(EquipPoint, DeviceID, bClearEquipPoint);
    // End:0x67
    if(m_WeaponMesh3P != none)
    {
        m_WeaponMesh3P.FxActivateGroup('MirrorActive', 0);
    }
    //return;    
}

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot)
{
    local TgPawn_Ying TgP;

    TgP = TgPawn_Ying(Owner);
    // End:0xBA
    if((TgP != none) && TgP.r_InhandTarget != none)
    {
        HitLocation = TgP.r_InhandTarget.Location;
        HitLocation += TgP.r_InhandHitOffset;
        return true;
    }
    return super.GetSimulatedBeamTarget(HitLocation, nEquipSlot);
    //return ReturnValue;    
}

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
        super.PlayFireAnimation(nEquipSlot, 0.7000000);        
    }
    else
    {
        // End:0x93
        if(fRefireTime > 0.3000000)
        {
            m_bHasFinishedBurst = true;
            SetTimer(0.3000000, false, 'EndYingLoopingBeam');
        }
    }
    //return;    
}

simulated function EndYingLoopingBeam()
{
    SetLoopingMuzzleEffects(false);
    //return;    
}

defaultproperties
{
    m_bHasFinishedBurst=true
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_YingInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}